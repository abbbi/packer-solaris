#!/bin/sh

# setup the vagrant key
# you can replace this key-pair with your own generated ssh key-pair
echo "Setting the vagrant ssh pub key"

sudo mkdir /export/home/vagrant
sudo chown -R vagrant:staff /export/home/vagrant
mkdir /export/home/vagrant/.ssh
chmod 700 /export/home/vagrant/.ssh
touch /export/home/vagrant/.ssh/authorized_keys
echo 'ssh-rsa AAAAB3NzaC1yc2EAAAABIwAAAQEA6NF8iallvQVp22WDkTkyrtvp9eWW6A8YVr+kz4TjGYe7gHzIw+niNltGEFHzD8+v1I2YJ6oXevct1YeS0o9HZyN1Q9qgCgzUFtdOKLv6IedplqoPkcmF0aYet2PkEDo3MlTBckFXPITAMzF8dJSIFo9D8HfdOV0IAdx4O7PtixWKn5y2hMNG0zQPyUecp4pzC6kivAIhyfHilFR61RGL+GPXQ2MWZWFYbAGjyiYJnAmCP3NOTd0jMZEnDkbUvxhMmBYSdETk1rRgm+R4LOzFUGaHqHDLKLX+FIPKcF96hrucXzcWyLbIbEgE98OHlnVYCzRdK8jlqm8tehUc9c9WhQ== vagrant insecure public key' >> /export/home/vagrant/.ssh/authorized_keys


chmod 600 /export/home/vagrant/.ssh/authorized_keys
chown -R vagrant:staff /export/home/vagrant/.ssh

date >> /etc/vagrant_build_timestamp


echo "Disabling sendmail and asr-norify"
# disable the very annoying sendmail
/usr/sbin/svcadm disable sendmail
/usr/sbin/svcadm disable asr-notify

echo "Write File Buffers"
sudo /usr/sbin/lockfs -af

echo "Clearing log files and zeroing disk, this might take a while"
cp /dev/null /var/adm/messages
cp /dev/null /var/log/syslog
cp /dev/null /var/adm/wtmpx
cp /dev/null /var/adm/utmpx
dd if=/dev/zero of=/EMPTY bs=1024
rm -f /EMPTY

echo "Post-install done"
