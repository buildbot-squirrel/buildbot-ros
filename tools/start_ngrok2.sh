#!/bin/bash
cd /home/buildbot
su - buildbot -c "./ngrok http -config=/home/buildbot/.ngrok2/ngrok.yml 8080 &"
sleep 60
sudo cp /var/www/buildbot/index_template.html  /var/www/buildbot/index.html
OUTPUT="$(python /home/buildbot/ngrok2/get_urlngrok.py)"
echo "${OUTPUT}" | sudo tee /var/www/buildbot/link
sudo sed -i "s/https/http/g" /var/www/buildbot/link
PUBLIC_URL=$(</var/www/buildbot/link)
echo ${PUBLIC_URL}
sudo sed -i "s!public_html!${PUBLIC_URL}!g" /var/www/buildbot/index.html
sudo /etc/init.d/apache2 restart
