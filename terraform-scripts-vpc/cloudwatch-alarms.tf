resource "aws_sns_topic" "alarm_email"{
  name = "cloudwatch_alarm"
}

resource "aws_cloudwatch_metric_alarm" "cpu" {
    alarm_name = "cpu_alarm"
    comparison_operator = "GreaterThanOrEqualToThreshold"
    evaluation_periods = "1"
    metric_name = "CPUUtilization"
    namespace = "AWS/EC2"
    period = "300"
    statistic = "Average"
    threshold = "80"
    alarm_description = "This alarm sends alert when CPU Utilization is over 80% for more than 5 minutes"
    alarm_actions = ["${aws_sns_topic.alarm_email.arn}"]
}
