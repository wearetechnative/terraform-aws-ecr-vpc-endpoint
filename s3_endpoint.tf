# s3 vpc endpoint uses a policy to control access.

data "aws_iam_policy_document" "s3_vpc_endpoint_policy" {

  statement {
    sid = "AllowAwsEcrS3Access"

    principals {
      type        = "AWS"
      identifiers = ["*"]
    }

    actions = [
      "s3:GetObject"
    ]

    resources = ["arn:aws:s3:::prod-${data.aws_region.current.name}-starport-layer-bucket/*"]
  }
}

resource "aws_vpc_endpoint" "s3" {
  vpc_id       = var.vpc_id #data.terraform_remote_state.vpc.outputs.vpc_id
  service_name = "com.amazonaws.${data.aws_region.current.name}.s3"

  policy = data.aws_iam_policy_document.s3_vpc_endpoint_policy.json
}
