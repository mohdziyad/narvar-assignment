# narvar-assignment

-- Environments provisioned entirely using Terraform and all the scripts are available under terraform-scripts-vpc. The AWS credentials for terraform are coded as ENVIRONMENT VARIABLES in the linux system. The tasks are:
  - VPC Creation (Covering subnet, igw and route tables)
  - Security Group for the instance to allow ingress from given ports
  - Launching the instance into the VPC
  - Creating security group for VPN and attaching it to the instance
  - Creating SNS Topic, IAM instance profile, IAM Policy to access cloudwatch, IAM role to attach to the instance, CPU Utilization alarm and Disk Utilization alarm.
  * SNS Topic subscription is done manually since terrafrom doesn't support EMAIL protocol for subscriptions.
  
 -- The software configuration management script are available under ansible-scripts. This does the following after environment setup:
  - Install nginx into the EC2 instance and start it. (Playbook name - nginx.yml)
  - Install Unzip and Perl to the instance and download and unzip aws monitoring scripts to a directory. (Playbook name - monitoring.yml)
  - Installing cron to run the disk utilization monitoring every 5 minutes from a shell script. (Playbook name - monitoring.yml)
  
 -- OpenVPN is installed into the instance and local openvpn client is used to connect to it. The routing was verified via dnsleaktest.com
