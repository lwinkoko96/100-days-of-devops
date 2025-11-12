output "KKE_instance_name" {
  value = aws_instance.xfusion-ec2.tags["Name"]
}

output "KKE_alarm_name" {
  value = aws_cloudwatch_metric_alarm.xfusion-alarm.alarm_name
}
