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

# Upload to S3
S3_BUCKET="s3://applicant-task/r5d4/"
AWS_ROLE="r5d4-role"

# Use IAM role to upload file
aws s3 cp $OUTPUT_FILE $S3_BUCKET

# Check if upload was successful
if [ $? -eq 0 ]; then
    echo "File successfully uploaded to S3."
else
    echo "File upload failed."
fi
