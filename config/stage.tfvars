region = "us-east-1"
vpc = {
    #name = "vpc"
    cidr                    = "12.0.0.0/16"
    public_subnet           = ["12.0.1.0/24", "12.0.2.0/24", "12.0.3.0/24" ]
    private_subnet          = ["12.0.4.0/24", "12.0.5.0/24", "12.0.6.0/24" ]
}
customer                    = "fullstack-labs"
environment                 = "stage"
instance-size               = "t2.micro"
keypair                     = "uet-admin"
profile                     = "aramzan"
root_volume_size            = "30" # size in GB
root_volume_type            = "gp2"
deployment-version          = "v1"
