module "vpc" {
    source                  = "./modules/vpc"
    vpc                     = var.vpc
    az                      = data.aws_availability_zones.available.names
    environment             = var.environment
    customer                = var.customer
    deployment-version      = var.deployment-version
}


module "ec2" {
  source                                = "./modules/ec2"
  vpc-id                                = module.vpc.vpc-id
  customer                              = var.customer
  environment                           = var.environment
  keypair                               = var.keypair
  private-subnet-id-1                   = module.vpc.private-subnet-1 
  private-subnet-id-2                   = module.vpc.private-subnet-2
  public-subnet-id-1                    = module.vpc.public-subnet-1
  public-subnet-id-2                    = module.vpc.public-subnet-2
  instance-size                         = var.instance-size
  ami_id                                = data.aws_ami.ubuntu.id
  root_volume_size                      = var.root_volume_size
  root_volume_type                      = var.root_volume_type
  deployment-version                    = var.deployment-version
  }


