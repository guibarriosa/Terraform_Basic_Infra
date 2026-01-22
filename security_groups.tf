locals {
  ingress = [
    /*{
    port        = 22
    description = "SSH"  -- If you want to use SSH
    protocol    = "tcp"
    },*/

    {
      port        = 80
      description = "HTTP"
      protocol    = "tcp"
    }
  ]
}

resource "aws_security_group" "ec2_sg" {
  vpc_id = module.vpc.vpc_id

  dynamic "ingress" {
    for_each = local.ingress
    content {
      description = ingress.value.description
      from_port   = ingress.value.port
      to_port     = ingress.value.port
      protocol    = ingress.value.protocol
      cidr_blocks = ["0.0.0.0/0"]
    }
  }

  egress {
    from_port   = 0
    to_port     = 0
    protocol    = "-1"
    cidr_blocks = ["0.0.0.0/0"]
  }

  tags = {
    Name = "${var.tag_name}_SG_EC2"
  }
}



resource "aws_security_group" "rds_sg" {
  vpc_id = module.vpc.vpc_id

  ingress {
    from_port       = 3306
    to_port         = 3306
    protocol        = "tcp"
    security_groups = [aws_security_group.ec2_sg.id]
  }

  egress {
    from_port   = 0
    to_port     = 0
    protocol    = "-1"
    cidr_blocks = ["0.0.0.0/0"]
  }

  tags = {
    Name = "${var.tag_name}_SG_BD"
  }
}