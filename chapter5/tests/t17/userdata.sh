#!/bin/bash
set -eou pipefail
yum update -y
yum install -y nginx
yum install -y https://s3.amazonaws.com/ec2-downloads-windows/SSMAgent/latest/linux_amd64/amazon-ssm-agent.rpm
systemctl enable nginx amazon-ssm-agent
systemctl start nginx amazon-ssm-agent
