provider "aws" {
    region = "eu-west-2"
}

resource "aws_instance" "db" {
    ami = "ami-098828924dc89ea4a"
    instance_type = "t2.micro"
}

resource "aws_instance" "web" {
    ami = "ami-098828924dc89ea4a"
    instance_type = "t2.micro"

    #create "db" ec2 instance before "web" one
    depends_on = [aws_instance.db]
}
