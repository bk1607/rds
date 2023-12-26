data "aws_ssm_parameter" "rds_user" {
  name = "dev.rds_user"

}
data "aws_ssm_parameter" "rds_pass" {
  name = "dev.rds_pass"
}

