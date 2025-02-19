#!/bin/bash

# Define output file
OUTPUT_FILE="/home/ubuntu/ec2info/ec2_instance_info.txt"

# Collect instance metadata
INSTANCE_ID=$(curl -s http://169.254.169.254/latest/meta-data/instance-id)
PUBLIC_IP=$(curl -s http://169.254.169.254/latest/meta-data/public-ipv4)
PRIVATE_IP=$(curl -s http://169.254.169.254/latest/meta-data/local-ipv4)
SECURITY_GROUPS=$(curl -s http://169.254.169.254/latest/meta-data/security-groups)

# Get OS details
OS_NAME=$(grep '^NAME=' /etc/os-release | cut -d '=' -f2 | tr -d '"')
OS_VERSION=$(grep '^VERSION=' /etc/os-release | cut -d '=' -f2 | tr -d '"')

# Get list of users with Bash or SH shell access
USERS=$(awk -F: '$7 ~ /(bash|sh)$/ {print $1}' /etc/passwd)

# Save to file
echo "Instance ID: $INSTANCE_ID" > $OUTPUT_FILE
echo "Public IP: $PUBLIC_IP" >> $OUTPUT_FILE
echo "Private IP: $PRIVATE_IP" >> $OUTPUT_FILE
echo "Security Groups: $SECURITY_GROUPS" >> $OUTPUT_FILE
echo "Operating System: $OS_NAME $OS_VERSION" >> $OUTPUT_FILE
echo "Users with Shell Access:" >> $OUTPUT_FILE
echo "$USERS" >> $OUTPUT_FILE


