data "aws_ssm_parameter" "rds_user" {
  name = "dev.rds_user"

}
data "aws_ssm_parameter" "rds_pass" {
  name = "dev.rds_pass"
}

data "aws_subnets" "vpc_subnets" {

  filter {
    name   = "tag:Name"
    values = ["db_private_subnet_1","db_private_subnet_2"]
  }

  # Add more filters or adjust as needed
}