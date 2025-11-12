output "KKE_vpc_name" {
  value = aws_vpc.devops-priv-vpc.tags["Name"]
}

output "KKE_subnet_name" {
  value = aws_subnet.devops-priv-subnet.tags["Name"]
}

output "KKE_ec2_private" {
  value = aws_instance.devops-priv-ec2.tags["Name"]
}