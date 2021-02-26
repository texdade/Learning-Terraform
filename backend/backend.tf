terraform {
    backend "s3" {
        #folder where to store the file to in the bucket 
        key = "terraform/tfstate.tfstate"
        bucket = "texdade-remote-backend-2021"
        region = "eu-west-2"
        access_key = ""
        secret_key = ""
    }
}