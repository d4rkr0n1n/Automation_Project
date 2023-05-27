#!/bin/bash

myname=Mridul
timestamp=$(date '+%d%m%Y-%H%M%S')
s3_bucket=upgrad-mridul

sudo apt update -y
sudo apt install awscli apache2 -y

sudo systemctl enable --now apache2

ufw allow 80

tar -cvf /tmp/$myname-httpd-logs-$timestamp.tar /var/log/apache2/

aws s3 cp /tmp/${myname}-httpd-logs-${timestamp}.tar s3://${s3_bucket}/${myname}-httpd-logs-${timestamp}.tar
