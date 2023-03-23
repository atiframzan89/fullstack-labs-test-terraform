region = "us-east-1"
vpc = {
    #name = "vpc"
    cidr                    = "10.0.0.0/16"
    public_subnet           = ["10.0.1.0/24", "10.0.2.0/24", "10.0.3.0/24" ]
    private_subnet          = ["10.0.4.0/24", "10.0.5.0/24", "10.0.6.0/24" ]
}
customer                    = "fullstack-labs"
environment                 = "dev"
instance-size               = "t2.micro"
keypair                     = "uet-admin"
profile                     = "aramzan"
root_volume_size            = "30" # size in GB
root_volume_type            = "gp2"
deployment-version          = "v1"
