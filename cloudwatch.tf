resource "aws_cloudwatch_metric_alarm" "high_cpu" {
  alarm_name          = "cpu-high-terminate"
  comparison_operator = "GreaterThanThreshold"
  evaluation_periods  = 1
  metric_name         = "CPUUtilization"
  namespace           = "AWS/EC2"
  period              = 300
  statistic           = "Average"
  threshold           = 50

  alarm_actions = [aws_autoscaling_policy.terminate.arn]

  dimensions = {
    AutoScalingGroupName = aws_autoscaling_group.asg.name
  }

}