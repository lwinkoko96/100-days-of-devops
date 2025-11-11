### Objective

Use **Terraform** to create an **IAM Policy** that grants **read-only access** to the EC2 console.

---

## main.tf

```hcl
resource "aws_iam_policy" "policy" {
  name        = "iampolicy_mark"
  description = "Read-only access to EC2 console"

  # Terraform's "jsonencode" function converts a
  # Terraform expression result to valid JSON syntax.
  policy = jsonencode({
    Version = "2012-10-17"
    Statement = [
      {
        Action = [
          "ec2:Describe*",
        ]
        Effect   = "Allow"
        Resource = "*"
      },
    ]
  })
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

Once applied, verify in **AWS Console → IAM → Policies**:

- Policy name: `iampolicy_mark`
- Description: `Read-only access to EC2 console`
- Permissions summary:
    - **Effect:** Allow
    - **Action:** ec2:Describe*
    - **Resource:** *

Or verify via AWS CLI:

```bash
aws iam get-policy --policy-arn arn:aws:iam::<account-id>:policy/iampolicy_mark
```

---

## Notes

- Always use `jsonencode()` when defining IAM policies to avoid JSON formatting errors.
- To attach this policy later, use the `aws_iam_role_policy_attachment` resource.

---

## Reference

🔗 [Terraform AWS IAM Policy Documentation](https://registry.terraform.io/providers/hashicorp/aws/latest/docs/resources/iam_policy)

🔗 [AWS IAM JSON Policy Reference](https://docs.aws.amazon.com/IAM/latest/UserGuide/reference_policies_elements.html)