# Define provider
provider "aws" {
  region = "us-east-1" # Change to your desired region
}

# Create a VPC
resource "aws_vpc" "my_vpc" {
  cidr_block = "20.0.0.0/16" # Change the CIDR block as needed

  tags = {
    Name = "MyVPC"
  }
}

# Create an internet gateway
resource "aws_internet_gateway" "my_igw" {
  vpc_id = aws_vpc.my_vpc.id

  tags = {
    Name = "MyIGW"
  }
}

# Create a default route table
resource "aws_route_table" "my_route_table" {
  vpc_id = aws_vpc.my_vpc.id

  route {
    cidr_block = "0.0.0.0/0"
    gateway_id = aws_internet_gateway.my_igw.id
  }

  tags = {
    Name = "MyRouteTable"
  }
}

# Associate the route table with the subnets
resource "aws_route_table_association" "my_route_table_association" {
  subnet_id      = aws_subnet.my_subnet.id
  route_table_id = aws_route_table.my_route_table.id
}

# Create a subnet
resource "aws_subnet" "my_subnet" {
  vpc_id            = aws_vpc.my_vpc.id
  cidr_block        = "20.0.1.0/24" # Change the CIDR block as needed
  availability_zone = "us-east-1a"  # Change to your desired availability zone

  tags = {
    Name = "MySubnet"
  }
}
