resource "aws_db_subnet_group" "db_subnets" {
  subnet_ids = module.vpc.private_subnets
}

resource "aws_db_instance" "db" {
  allocated_storage      = 20
  engine                 = "mysql"
  instance_class         = "db.${var.instance_type}"
  username               = "admin"
  password               = "admin123"
  db_subnet_group_name   = aws_db_subnet_group.db_subnets.name
  vpc_security_group_ids = [aws_security_group.rds_sg.id]
  publicly_accessible    = false
  skip_final_snapshot    = true

  tags = {
    Name = "${var.tag_name}_DB"
  }
}