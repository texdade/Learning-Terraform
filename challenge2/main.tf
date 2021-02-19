provider "aws" {
    region = "eu-west-2"
}

resource "aws_instance" "ec2_dbserver" {
    ami = "ami-098828924dc89ea4a"
    instance_type = "t2.micro"

    tags = {
        Name = "DB Server"
    }
}

output "DB_Server_private_IP" {
    value = aws_instance.ec2_dbserver.private_ip
}

resource "aws_instance" "ec2_webserver" {
    ami = "ami-098828924dc89ea4a"
    instance_type = "t2.micro"
    security_groups = [aws_security_group.webtraffic.name]
    user_data = file("server-script.sh")
    tags = {
        Name = "Web Server"
    }
}

resource "aws_eip" "elasticip" {
    instance = aws_instance.ec2_webserver.id
}

output "Web_Server_EIP" {
    value = aws_eip.elasticip.public_ip
}

variable "ingressrules" {
    type = list(number)
    default = [80, 443]
}

variable "egressrules" {
    type = list(number)
    default = [80, 443]
}

resource "aws_security_group" "webtraffic" {
    name = "Allow80/443"
    dynamic "ingress" {
        iterator = port
        for_each = var.ingressrules
        content {
            from_port = port.value
            to_port = port.value
            protocol = "TCP"
            cidr_blocks = ["0.0.0.0/0"]
        }
    }
    
    dynamic "egress" {
        iterator = port
        for_each = var.egressrules
        content {
            from_port = port.value
            to_port = port.value
            protocol = "TCP"
            cidr_blocks = ["0.0.0.0/0"]
        }
    }
}

