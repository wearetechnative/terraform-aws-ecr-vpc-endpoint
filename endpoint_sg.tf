#Security group configuration
resource "aws_security_group" "interface_endpoint_sg" {

  name        = "interface-endpoint-sg"
  description = "Shared VPC interface endpoint security group."
  vpc_id      = var.vpc_id #data.terraform_remote_state.vpc.outputs.vpc_id

  tags = {
    Name = "interface-endpoint-sg"
  }
}

resource "aws_vpc_security_group_ingress_rule" "allow_traffic" {
  for_each = toset(var.ecr_vpc_endpoint_access_sg_ids)

  security_group_id = aws_security_group.interface_endpoint_sg.id

  from_port   = 443
  ip_protocol = "tcp"
  to_port     = 443

  referenced_security_group_id = each.value
}

resource "aws_vpc_security_group_egress_rule" "allow_wan_ipv4_interface_endpoint" {
  security_group_id = aws_security_group.interface_endpoint_sg.id
  cidr_ipv4         = "0.0.0.0/0"
  ip_protocol       = "-1"
}
