#!/bin/sh

apt-get update
apt-get upgrade
apt-get install sudo bzip2 unzip zip ssh rsync curl wget mc git tofrodos ntpdate hdparm sdparm ethtool bsd-mailx ssmtp cron-apt smartmontools iptraf sysstat net-tools bridge-utils lockfile-progs

# unavailable in some cases
apt-get install firmware-linux

# data recovery
#apt-get install ntfs-3g exfat-fuse jmtpfs mtp-tools gphoto2

# azure storage
#apt-get install keyutils cifs-utils

# raspbian-jessie:
#apt-get install php5-cli

# raspbian-stretch:
apt-get install php-cli

apt-get purge popularity-contest mlocate exim4*
