
variable "private_subnet_ids" {
  description = "The IDs of the private subnets in which to create the VPC endpoints."
  type        = list(string)
}

variable "vpc_id" {
  description = "The ID of the VPC in which to create the VPC endpoints."
  type        = string
}

# If using EC2 instances to host ECS tasks, then its the security group of the ASG.
# If using Fargate its either the ecs service security group or security group attached to the fargate task.
variable "ecr_vpc_endpoint_access_sg_ids" {
  description = "The ID of the security group to allow access to the ECR VPC endpoint."
  type        = list(string)
}
