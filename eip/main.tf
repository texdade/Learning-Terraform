provider "aws" {
    region = "eu-west-2"
}

resource "aws_instance" "ec2" {
    ami = "ami-098828924dc89ea4a"
    instance_type = "t2.micro"
}

resource "aws_eip" "elasticip" {
    instance = aws_instance.ec2.id
}

output "EIP" {
    value = aws_eip.elasticip.public_ip
}
