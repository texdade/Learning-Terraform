provider "aws" {
    region = "eu-west-2"
}

module "ec2module" {
    source = "./ec2"
    ec2name = "Ec2ModuleInstance"
}

output "module_output" {
    value = module.ec2module.instance_id
}