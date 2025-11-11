### Objective

Use **Terraform** to create an AWS **Security Group** with HTTP and SSH ingress rules for application servers.

---

## main.tf

```hcl
resource "aws_security_group" "xfusion-sg" {
  name        = "xfusion-sg"
  description = "Security group for Nautilus App Servers"
  #vpc_id      = aws_vpc.main.id

  tags = {
    Name = "xfusion-sg"
  }
}

resource "aws_vpc_security_group_ingress_rule" "allow_http_ipv4" {
  security_group_id = aws_security_group.xfusion-sg.id
  cidr_ipv4         = "0.0.0.0/0"
  from_port         = 80
  ip_protocol       = "HTTP"
  to_port           = 80
}

resource "aws_vpc_security_group_ingress_rule" "allow_ssh_ipv4" {
  security_group_id = aws_security_group.xfusion-sg.id
  cidr_ipv4         = "0.0.0.0/0"
  from_port         = 22
  ip_protocol       = "SSH"
  to_port           = 22
}
```

---

## Commands to Run

```bash
terraform init
terraform plan
terraform apply
```

---

## Verification

- Verify in **AWS Console → EC2 → Security Groups**:
    - Security Group name: `xfusion-sg`
    - Inbound Rules:
        - HTTP (Port 80) — 0.0.0.0/0
        - SSH (Port 22) — 0.0.0.0/0
    - Outbound Rule: Allow all (default)

---

## Reference

🔗 [Terraform AWS Security Group Documentation](https://registry.terraform.io/providers/hashicorp/aws/latest/docs/resources/security_group)

🔗 [Terraform AWS Security Group Rule Documentation](https://registry.terraform.io/providers/hashicorp/aws/latest/docs/resources/vpc_security_group_ingress_rule)