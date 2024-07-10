# Amazon ECS tasks hosted on Amazon EC2 instances require both Amazon ECR endpoints and the Amazon S3 gateway endpoint.

data "aws_iam_policy_document" "allow_account_access_ecr_endpoints" {

  statement {
    sid = "AllowPull"

    principals {
      type        = "AWS"
      identifiers = ["arn:aws:iam::${data.aws_caller_identity.current.account_id}:root"]
    }

    actions = [
      "ecr:BatchCheckLayerAvailability",
      "ecr:GetDownloadUrlForLayer",
      "ecr:BatchGetImage",
      "ecr:GetAuthorizationToken"
    ]

    resources = ["*"]
  }
}

resource "aws_vpc_endpoint" "ecr_endpoints" {
  for_each = toset(
    [
      "com.amazonaws.${data.aws_region.current.name}.ecr.dkr",
      "com.amazonaws.${data.aws_region.current.name}.ecr.api"
    ]
  )

  vpc_id            = var.vpc_id #data.terraform_remote_state.vpc.outputs.vpc_id
  service_name      = each.value
  vpc_endpoint_type = "Interface"

  subnet_ids = var.private_subnet_ids #data.terraform_remote_state.vpc.outputs.private_subnets

  private_dns_enabled = true

  policy = data.aws_iam_policy_document.allow_account_access_ecr_endpoints.json
}
