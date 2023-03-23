resource "aws_vpc" "customer-vpc" {
    # name              = var.customer
    cidr_block        = var.vpc.cidr
    tags = {
      "Name"          = "${var.customer}-${var.environment}-${var.deployment-version}"
      "Customer"      = var.customer
      "Environment"   = var.environment
      "Terraform"     = "True"
    }
}

resource "aws_subnet" "public_subnet" {
    count               = length(var.vpc.public_subnet)
    vpc_id              = aws_vpc.customer-vpc.id
    cidr_block          = element(var.vpc.public_subnet, count.index)
    availability_zone   = element(var.az, count.index)
    depends_on          = [ aws_vpc.customer-vpc, aws_route_table.public_rt_1  ]
    map_public_ip_on_launch = true

    
    tags = {
      "Name"                            = "${var.customer}-public-subnet-${count.index}-${var.deployment-version}"
      "Environment"                     = var.environment
      "Customer"                        = var.customer
      "Terraform"                       = "True"
    }
}

resource "aws_subnet" "private_subnet" {
    count               = length(var.vpc.private_subnet)
    vpc_id              = aws_vpc.customer-vpc.id
    cidr_block          = element(var.vpc.private_subnet, count.index)
    availability_zone   = element(var.az, count.index)
    depends_on          = [ aws_vpc.customer-vpc,
                            aws_route_table.private_rt_1 ]

    
    tags = {
      "Name"                            = "${var.customer}-private-subnet-${count.index}-${var.deployment-version}"
      "Environment"                     = var.environment
      "Customer"                        = var.customer
      "Terraform"                       = "True"                      
    }
}

resource "aws_internet_gateway" "customer-igw" {
    vpc_id        = aws_vpc.customer-vpc.id
    tags          = {
                      "Name"          = "${var.customer}-igw-${var.environment}-${var.deployment-version}"
                      "Environment"   = var.environment
                      "Customer"      = var.customer
                      "Terraform"     = "True"
                    }
 
}


resource "aws_route_table" "private_rt_1" {
    vpc_id        = aws_vpc.customer-vpc.id
    depends_on    = [ aws_nat_gateway.customer-igw ]
    route {
      cidr_block  = "0.0.0.0/0"
      gateway_id  = aws_nat_gateway.customer-igw.id 
    }
    tags = {
      "Name"          = "${var.customer}-private-rt-${var.environment}-1-${var.deployment-version}"
      "Environment"   = var.environment
      "Customer"      = var.customer
      "Terraform"     = "True"
    }
}

resource "aws_route_table" "public_rt_1" {
    vpc_id        = aws_vpc.customer-vpc.id
    depends_on    = [ aws_internet_gateway.customer-igw ]
    route {
      cidr_block  = "0.0.0.0/0"
      gateway_id  = aws_internet_gateway.customer-igw.id
     } 
    tags = {
      "Name"          = "${var.customer}-public-rt-${var.environment}-1-${var.deployment-version}"
      "Environment"   = var.environment
      "Customer"      = var.customer
      "Terraform"     = "True"
    }
}

resource "aws_route_table_association" "public_rt_1_association" {
  count               = length(var.vpc.public_subnet)
  subnet_id           = aws_subnet.public_subnet[count.index].id
  route_table_id      = aws_route_table.public_rt_1.id
}

resource "aws_route_table_association" "private_rt_1_association" {
  count               = length(var.vpc.private_subnet)
  subnet_id           = aws_subnet.private_subnet[count.index].id
  route_table_id      = aws_route_table.private_rt_1.id
}

resource "aws_nat_gateway" "customer-igw" {
  allocation_id       = aws_eip.customer-eip.id
  subnet_id           = aws_subnet.public_subnet[0].id
  depends_on          = [ aws_internet_gateway.customer-igw, aws_eip.customer-eip ]
  tags = {
    "Name"          = "${var.customer}-igw-${var.environment}-${var.deployment-version}"
    "Environment"   = var.environment
    "Customer"      = var.customer
    "Terraform"     = "True"
  }
  
}

resource "aws_eip" "customer-eip" {
    tags = {
      "Name"          = "${var.customer}-eip-${var.environment}-${var.deployment-version}"
      "Environment"   = var.environment
      "Customer"      = var.customer
      "Terraform"     = "True"
    }
  
}

resource "aws_db_subnet_group" "customer-subnet-group" {
  name       = "${var.customer}-subnet-group-${var.environment}-${var.deployment-version}"
  subnet_ids = [ aws_subnet.private_subnet[0].id, aws_subnet.private_subnet[1].id ]

  tags = {
      "Name"          = "${var.customer}-subnet-group-${var.environment}-${var.deployment-version}"
      "Environment"   = var.environment
      "Customer"      = var.customer
      "Terraform"     = "True"
  }
}