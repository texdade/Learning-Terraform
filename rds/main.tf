provider "aws" {
    region = "eu-west-2"
}

resource "aws_db_instance" "myRDS" {
    #name of db inside rds instance
    name = "myDB"
    #instance unique identifier
    identifier = "my-first-rds"
    instance_class = "db.t2.micro"
    engine = "mariadb"
    engine_version = "10.2.21"
    username = "user"
    password = "unsecure"
    port = 3306
    allocated_storage = 20
    #useful when using terraform destroy
    skip_final_snapshot = true
}