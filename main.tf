resource "aws_rds_cluster" "default" {
  cluster_identifier      = "${var.env}-${var.cluster_name}"
  engine                  = var.engine_name
  engine_version          = var.engine_version
  database_name           = var.database_name
  master_username         = data.aws_ssm_parameter.rds_user.value
  master_password         = data.aws_ssm_parameter.rds_pass.value
  backup_retention_period = var.backup
  preferred_backup_window = var.backup_window
  db_subnet_group_name = aws_db_subnet_group.default.name
}

resource "aws_rds_cluster_instance" "cluster_instances" {
  count              = var.instance_count
  identifier         = "${var.env}-${var.cluster_name}"
  cluster_identifier = aws_rds_cluster.default.id
  instance_class     = var.instance_class
  engine             = aws_rds_cluster.default.engine
  engine_version     = aws_rds_cluster.default.engine_version
}



resource "aws_db_subnet_group" "default" {
  name       = "${var.env}-${var.subnet_group_name}"
  subnet_ids = var.db_subnet_ids

  tags = {
    Name = "My DB subnet group"
  }
}