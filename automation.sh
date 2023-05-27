#!/bin/bash
myname=Mridul
timestamp=$(date '+%d%m%Y-%H%M%S')
s3_bucket=upgrad-mridul

sudo apt update -y
sudo apt install awscli apache2 -y

sudo systemctl enable --now apache2

ufw allow 80

tar -cvf /tmp/${myname}-httpd-logs-${timestamp}.tar /var/log/apache2/

aws s3 cp /tmp/${myname}-httpd-logs-${timestamp}.tar s3://${s3_bucket}/${myname}-httpd-logs-${timestamp}.tar

if [ $(ls /var/www/html | grep inventory.html | wc -l) == 0 ]
then
        echo "<b>Log Type &emsp;  Date Created &emsp;&emsp;&emsp;  Type &emsp;  Size</b><br>" > /var/www/html/inventory
else
        echo "inventory.html already exists"
fi

echo -e "http-logs &emsp; ${timestamp} &emsp;&emsp;&nbsp; tar &emsp;&nbsp;&nbsp $(ls -sh /tmp/${myname}-httpd-logs-${timestamp}.tar | awk '{print $1}')<br>" >> /var/www/html/inventory.html

if [ $(crontab -l | grep "* * * * * root /root/Automation_Project/automation.sh" | wc -l) == 0 ]
then
        echo "* * * * * root /root/Automation_Project/automation.sh" > /etc/cron.d/automation
else
        echo "crontab already exists"
fi