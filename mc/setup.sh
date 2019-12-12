#!/bin/bash

setup_midnight_commander_for_user() {
	user=$1
	group=`id -gn $user`
	home=`getent passwd $user |cut -d: -f 6`

	path=".config/mc/ini"
	wrapper=/usr/share/mc/bin/mc-wrapper.sh

	if [ -d $home ]; then
		echo "setting up midnight commander configuration for user $user"
		mkdir -p `dirname $home/$path`
		cp -f mc.ini $home/$path
		chown $user:$group $home/$path

		rc=$home/.bashrc

		if [ ! -f $rc ]; then
			touch $rc
		fi

		if [ "`grep 'alias mc' $rc`" = "" ] && [ -f $wrapper ]; then
			echo >>$rc
			echo "alias mc='. $wrapper'" >>$rc
		fi

		if [ "`grep mcedit $rc`" = "" ]; then
			echo >>$rc
			echo "export EDITOR=mcedit" >>$rc
		fi
	fi
}



echo "setting up midnight commander profiles"
cp -f mc.skin /usr/share/mc/skins/wheezy.ini

USERS="root ubuntu ec2-user admin pi fa tomek tklim"

for U in $USERS; do
	if grep -q ^$U /etc/passwd; then
		setup_midnight_commander_for_user $U
	fi
done


loc="/usr/share/locale/pl/LC_MESSAGES"

if [ -f $loc/mc.mo ]; then
	echo "disabling midnight commander polish translation"
	mv $loc/mc.mo $loc/midc.mo
fi
