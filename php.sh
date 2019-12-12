#!/bin/bash

set_php_option() {
	file=$1
	key=$2
	value=$3

	if ! grep -q ^$key $file; then
		echo >>$file
		echo "$key =" >>$file
	fi

	sed -i -e "s/^\($key\)[ =].*/\\1 = $value/" $file
}

process_php_ini() {
	file=$1
	if [ -f $file ]; then

		if [ ! -f $file.orig ]; then
			cp $file $file.orig
		fi

		set_php_option $file error_log '\/var\/log\/php\/php-error.log'
		set_php_option $file include_path '\".:\/usr\/share\/php\"'
		set_php_option $file memory_limit 512M
		set_php_option $file log_errors On
		set_php_option $file magic_quotes_gpc Off
		set_php_option $file expose_php Off
		set_php_option $file allow_url_fopen Off
		set_php_option $file post_max_size 16M
		set_php_option $file upload_max_filesize 16M
	fi
}

link_php_compat_directory() {
	version=$1
	if [ ! -e /etc/php5 ] && [ -d /etc/php/$version ]; then
		echo "found php $version, creating symlink /etc/php5"
		ln -s /etc/php/$version /etc/php5
	fi
}


echo "setting up php configuration"
mkdir -p /var/log/php
touch /var/log/php/php-error.log
chown -R www-data:www-data /var/log/php
chmod g+w /var/log/php/*.log

link_php_compat_directory 7.0
link_php_compat_directory 7.1
link_php_compat_directory 7.2
link_php_compat_directory 7.3
process_php_ini /etc/php5/cli/php.ini
