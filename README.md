# ec2_metadata_upload_s3
EC2 Metadata Collector – A Bash script that gathers AWS EC2 instance metadata and uploads it to an S3 bucket.

This repository contains a Bash script that collects metadata from an AWS EC2 instance, including instance ID, public and private IP addresses, security groups, operating system details, and users with shell access. 
The collected data is saved to a text file and uploaded to an S3 bucket using the AWS CLI.
