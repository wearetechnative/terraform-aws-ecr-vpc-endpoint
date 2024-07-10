
Example usage:

```terraform
module "vpc_ecr_endpoint" {
   source = "path/to/module"

   vpc_id              = "vpc-12345678"
   subnet_ids          = ["subnet-12345678", "subnet-87654321"]
   security_group_ids  = ["sg-12345678"]

   endpoint_policy     = <<EOF
      {
         "Statement": [
            {
               "Sid": "AllowECRAccess",
               "Principal": "*",
               "Action": [
                  "ecr:GetAuthorizationToken",
                  "ecr:BatchCheckLayerAvailability",
                  "ecr:GetDownloadUrlForLayer",
                  "ecr:GetRepositoryPolicy",
                  "ecr:DescribeRepositories",
                  "ecr:ListImages",
                  "ecr:DescribeImages",
                  "ecr:BatchGetImage"
               ],
               "Effect": "Allow",
               "Resource": "*"
            }
         ]
      }
   EOF

   enable_private_dns_resolution = true
}
```
