resource "aws_autoscaling_group" "asg" {
  desired_capacity    = 1
  min_size            = 0
  max_size            = 1
  vpc_zone_identifier = [module.vpc.public_subnets[0]]

  launch_template {
    id      = aws_launch_template.my_server.id
    version = "$Latest"
  }

  tag {
    key                 = "Name"
    value               = "${var.tag_name}_Server"
    propagate_at_launch = true
  }
}

resource "aws_autoscaling_policy" "terminate" {
  name                   = "terminate-on-high-cpu"
  scaling_adjustment     = -1
  adjustment_type        = "ChangeInCapacity"
  cooldown               = 300
  autoscaling_group_name = aws_autoscaling_group.asg.name
}

