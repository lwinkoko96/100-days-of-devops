## Overview

This task focuses on deploying an **EC2 instance** inside a **Private VPC Subnet** using **Terraform**.

By isolating the EC2 instance within a private subnet, the environment achieves better **security** and **network control**.

---

## Define Variables — `variables.tf`

The CIDR ranges for the VPC and Subnet are defined as variables to keep the configuration **dynamic** and **reusable**.

```hcl
variable "KKE_VPC_CIDR" {
  description = "CIDR block for the VPC"
  type        = string
  default     = "10.0.0.0/16"
}

variable "KKE_SUBNET_CIDR" {
  description = "CIDR block for the subnet"
  type        = string
  default     = "10.0.1.0/24"
}
```


---

## Build Infrastructure — `main.tf`

In this file, the following resources are defined:

- **VPC:** `devops-priv-vpc`
- **Subnet:** `devops-priv-subnet`
- **Security Group:** `devops-priv-sg` (allows traffic only within the VPC)
- **EC2 Instance:** `devops-priv-ec2` (launched inside the private subnet)

---

## Output Configuration - `outputs.tf`

The `outputs.tf` file displays resource names after Terraform deployment.

```hcl
output "KKE_vpc_name" {
  value = aws_vpc.devops-priv-vpc.tags["Name"]
}

output "KKE_subnet_name" {
  value = aws_subnet.devops-priv-subnet.tags["Name"]
}

output "KKE_ec2_private" {
  value = aws_instance.devops-priv-ec2.tags["Name"]
}
```

---

## Commands to Run

```bash
terraform init
terraform plan
terraform apply
```

**Expected Output:**

```
KKE_vpc_name     = "devops-priv-vpc"
KKE_subnet_name  = "devops-priv-subnet"
KKE_ec2_private  = "devops-priv-ec2"
```

---

## Verification in AWS Console

- **VPC:** `devops-priv-vpc` with CIDR `10.0.0.0/16`
- **Subnet:** `devops-priv-subnet` — private CIDR `10.0.1.0/24`
- **EC2 Instance:** `devops-priv-ec2` — no public IP (private-only access)
- **Security Group:** Restricts inbound/outbound traffic to the VPC CIDR

---

## Reference Links

- [Terraform AWS VPC Resource](https://registry.terraform.io/providers/hashicorp/aws/latest/docs/resources/vpc)
- [Terraform AWS Subnet Resource](https://registry.terraform.io/providers/hashicorp/aws/latest/docs/resources/subnet)
- [Terraform AWS Security Group Resource](https://registry.terraform.io/providers/hashicorp/aws/latest/docs/resources/security_group)
- [Terraform AWS Instance Resource](https://registry.terraform.io/providers/hashicorp/aws/latest/docs/resources/instance)