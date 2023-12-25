resource "aws_rds_cluster" "default" {
  cluster_identifier      = var.cluster_name
  engine                  = var.engine_name
  engine_version          = "5.7.mysql_aurora.2.11.4"
  database_name           = "mydb"
  master_username         = data.aws_ssm_parameter.rds_user
  master_password         = data.aws_ssm_parameter.rds_pass
  backup_retention_period = 2
  preferred_backup_window = "07:00-09:00"
  db_subnet_group_name = aws_db_subnet_group.default.name
}

resource "aws_rds_cluster_instance" "cluster_instances" {
  count              = 1
  identifier         = var.cluster_name
  cluster_identifier = aws_rds_cluster.default.id
  instance_class     = "db.t3.medium"
  engine             = aws_rds_cluster.default.engine
  engine_version     = aws_rds_cluster.default.engine_version
}

locals {
  db_subnet_ids =  data.aws_subnets.vpc_subnets.ids
}

resource "aws_db_subnet_group" "default" {
  name       = "main"
  subnet_ids = local.db_subnet_ids

  tags = {
    Name = "My DB subnet group"
  }
}