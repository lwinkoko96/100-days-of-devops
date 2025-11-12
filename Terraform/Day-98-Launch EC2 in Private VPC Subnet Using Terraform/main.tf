resource "aws_vpc" "devops-priv-vpc" {
  cidr_block       = var.KKE_VPC_CIDR

  tags = {
    Name = "devops-priv-vpc"
  }
}

resource "aws_subnet" "devops-priv-subnet" {
  vpc_id     = aws_vpc.devops-priv-vpc.id
  cidr_block = var.KKE_SUBNET_CIDR

  tags = {
    Name = "devops-priv-subnet"
  }
}

resource "aws_security_group" "devops-priv-sg" {
  name        = "devops-priv-sg"
  description = "Allow access only within VPC CIDR"
  vpc_id      = aws_vpc.devops-priv-vpc.id

  ingress {
    from_port   = 0
    to_port     = 65535
    protocol    = "tcp"
    cidr_blocks = [var.KKE_VPC_CIDR]
  }

  egress {
    from_port   = 0
    to_port     = 0
    protocol    = "-1"
    cidr_blocks = [var.KKE_VPC_CIDR]
  }

  tags = {
    Name = "devops-priv-sg"
  }
}

resource "aws_instance" "devops-priv-ec2" {
  ami           = "ami-0c55b159cbfafe1f0" # Amazon Linux 2 AMI for us-east-1
  instance_type = "t2.micro"
  subnet_id     = aws_subnet.devops-priv-subnet.id
  vpc_security_group_ids = [aws_security_group.devops-priv-sg.id]

  tags = {
    Name = "devops-priv-ec2"
  }
}