resource "aws_db_instance" "default" {
  depends_on             = [aws_security_group.default]
  identifier             = var.database_name
  allocated_storage      = var.storage
  engine                 = "postgres"
  engine_version         = var.engine_version
  port                   = "5432"
  instance_class         = var.instance_class
  name                   = var.database_name
  username               = var.database_username
  password               = var.database_password
  publicly_accessible    = "false"
  vpc_security_group_ids = ["${aws_security_group.default.id}"]
  skip_final_snapshot    = "true"
  availability_zone      = "us-west-2b"
}


resource "aws_security_group" "default" {
  name        = "mydb_dev_rds_sg"
  description = "Allow all inbound traffic"
  vpc_id      = var.vpc_id

  ingress {
    from_port   = 5432
    to_port     = 5432
    protocol    = "TCP"
    # mydb-dev-sg # tem que mudar o security group :(
    security_groups = ["sg-07b109cdf8982e64f"]

  }

  tags = {
    Name = "mydb-dev"
    Environment = "dev"
    Owner = "roger"
    Product = "mydb"
  }
}