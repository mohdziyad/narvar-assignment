resource "aws_sns_topic" "alarm_email"{
  name = "cloudwatch_alarm"
}

resource "aws_iam_instance_profile" "ec2-instance-profile" {
    name = "instance-profile-web"
    role = "${aws_iam_role.cloudwatch_role.name}"
}

resource "aws_iam_role" "cloudwatch_role" {
    name = "cloudwatch_role_ec2"
    assume_role_policy = <<EOF
{
  "Version": "2012-10-17",
  "Statement": [
    {
      "Action": "sts:AssumeRole",
      "Principal": {
        "Service": "ec2.amazonaws.com"
      },
      "Effect": "Allow",
      "Sid": ""
    }
  ]
}
EOF
}
resource "aws_iam_role_policy" "cloudwatch-policy" {
    name = "cloudwatch-iam-policy"
    role = "${aws_iam_role.cloudwatch_role.id}"
    policy = <<EOF
{
  "Version": "2012-10-17",
  "Statement": [
    {
      "Action": "cloudwatch:*",
      "Effect": "Allow",
      "Resource": "*"
    }
  ]
}
EOF
}

resource "aws_cloudwatch_metric_alarm" "cpu" {
    alarm_name = "cpu_alarm"
    comparison_operator = "GreaterThanThreshold"
    evaluation_periods = "1"
    metric_name = "CPUUtilization"
    namespace = "AWS/EC2"
    dimensions{
      InstanceId = "${aws_instance.web.id}"
    }
    period = "300"
    statistic = "Average"
    threshold = "80"
    alarm_description = "This alarm sends alert when CPU Utilization is over 80% for more than 5 minutes"
    alarm_actions = ["${aws_sns_topic.alarm_email.arn}"]
}

resource "aws_cloudwatch_metric_alarm" "disk" {
    alarm_name = "disk_space"
    comparison_operator = "GreaterThanThreshold"
    evaluation_periods = "1"
    metric_name = "DiskSpaceUsed"
    namespace = "custom-disk"
    dimensions{
      InstanceId = "${aws_instance.web.id}"
    }
    period = "300"
    statistic = "Average"
    threshold = "90"
    alarm_description = "This alarm sends alert when Disk Space used is over 90%"
    alarm_actions = ["${aws_sns_topic.alarm_email.arn}"]
}
