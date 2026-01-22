resource "aws_launch_template" "my_server" {
  name_prefix   = "my_server"
  #key_name      = "teste" -- If you want to use SSH
  image_id      = "ami-03fb142dfda5eefb1"
  instance_type = var.instance_type
  network_interfaces {
    associate_public_ip_address = true
    security_groups             = [aws_security_group.ec2_sg.id]
  }

  iam_instance_profile {
  name = aws_iam_instance_profile.ec2_profile.name
}


  user_data = base64encode(<<EOF
#!/bin/bash
yum update -y
yum install -y httpd
systemctl enable httpd
systemctl start httpd
echo "Website up and running" > /var/www/html/index.html
EOF
  )
}

