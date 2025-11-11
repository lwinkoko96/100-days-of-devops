### Objective

Use **Terraform** to provision an **EC2 instance** in AWS with a specific AMI, instance type, and key pair.

---

### main.tf

```hcl
resource "aws_instance" "datacenter-ec2" {
  ami           = "ami-0c101f26f147fa7fd"
  instance_type = "t2.micro"
  key_name = "datacenter-kp"

  tags = {
    Name = "datacenter-ec2"
  }
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

After the instance is created, verify in **AWS Console → EC2 → Instances**:

- Instance Name: `datacenter-ec2`
- Instance Type: `t2.micro`
- AMI ID: `ami-0c101f26f147fa7fd`
- Key Pair: `datacenter-kp`
- Status: **Running**

You can also confirm via CLI:

```bash
aws ec2 describe-instances --query "Reservations[*].Instances[*].[InstanceId,State.Name,Tags]" --output table
```

---

## Reference

🔗 [Terraform AWS Instance Documentation](https://registry.terraform.io/providers/hashicorp/aws/latest/docs/resources/instance)

🔗 [AWS EC2 Official Documentation](https://docs.aws.amazon.com/AWSEC2/latest/UserGuide/EC2_GetStarted.html)