resource "aws_sns_topic" "alarm_email"{
  name = "cloudwatch_alarm"
}

resource "aws_iam_role" "cloudwatch_role" {
    name = "cloudwatch_role_ec2"
    assume_role_policy = <<EOF
    {
      "Version" : "2012-10-17",
      "Statement" : 
        {
          "Sid" : "cloudwatc-ec2",
          "Action" : "cloudwatch:*",
          "Effect" : "Allow",
          "Resource" : "arn:aws:ec2:ap-south-1:261773514547:instance/i-0cab02d22591c5fb4"
        }
    }
EOF
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
