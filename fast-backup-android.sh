#!/bin/bash

#  Automates the backup process android.
#
#  Written by: Fernando Magalhães (fm4lloc) <fm4lloc@gmail.com>
#
#  This program is free software; you can redistribute it and/or modify
#  it under the terms of the GNU General Public License as published by
#  the Free Software Foundation; either version 2 of the License, or
#  (at your option) any later version.
#  

declare -r NAME="Fast Backup Android"
declare -r VERSION="0.12.4"

#  [SETTINGS] - full path to the binary: adb
#
declare -r ADB_BIN="/usr/local/bin/adb"

#  [SETTINGS] - add the path of files or folders to backup.
#
#  ATTENTION! remove the bar (/) end.
#  change this	: /a/b/c/
#  for this	: /a/b/c
#
declare -r PATH_FILES=(
	"/data/data/com.android.providers.contacts/databases/contacts2.db"
	"/data/data/com.android.providers.telephony/databases/mmssms.db"
	"/data/data/com.android.providers.settings/databases/settings.db"
	"/data/data/com.android.providers.calendar/databases/calendar.db"
	"/data/data/com.android.deskclock/databases/alarms.db"
	"/data/data/com.android.email/databases"
	"/data/data/com.android.settings"
)

function help()
{
	version
	echo -e \
	"\n  -b [<local>] | --backup [<local>]  - create backup."\
	"\n                                    "\
	"A folder will be created automatically if none is specified."\
	"\n  -r <local> | --restore <local>     - restore backup."\
	"\n  -h | --help                        - show this help message."\
	"\n  -v | --version                     - show version num."
}

function version()
{
	echo "${NAME} version ${VERSION}"
}

function create_dir()
{
	if [ "$1" == "" ]; then
		local -r dir_name="bkp-`date +%Y%m%d-%I%M%S`"
	else
		local -r dir_name="$1"
	fi

	if [ -d "$dir_name" ]; then
		echo "Error: $dir_name already exists. Run $0 again."
		exit -1
	else
		mkdir -v "$dir_name"
	fi

	backup_data
}

function backup_data()
{
	echo "Started..."
	for (( i = 0 ; i < ${#PATH_FILES[@]} ; i++ )) do
		mkdir -p `expr "${dir_name}${PATH_FILES[$i]}" : '\(.*\/\)'`
		$ADB_BIN pull "${PATH_FILES[$i]}" "${dir_name}${PATH_FILES[$i]}"
	done
	echo "Finished!"
}

function check_restore()
{
	local -r dir_restore=`echo "$1" | sed -e 's/\/$//g'`
	if [ -d "$dir_restore" ]
	then
		echo "Proceed with the restore? [N/y]"
		read -n 1 -r
		if [[ $REPLY =~ ^[Yy]$ ]]; then
			restore_data
		else
			exit -1
		fi
	else
		echo "Error: \"$dir_restore\" does not exists. :-("
		exit -1
	fi
}

function restore_data()
{
	echo "Restoring..."
	for (( i = 0 ; i < ${#PATH_FILES[@]} ; i++ )) do
		$ADB_BIN push "${dir_restore}${PATH_FILES[$i]}" "${PATH_FILES[$i]}"
	done
	echo "Finished"

	echo "sync..."
	$ADB_BIN shell sync
	echo "reboot device..."
	$ADB_BIN shell reboot
	echo "Finished!"
}

# MAIN
	case $1 in
-b | --backup)
	create_dir "$2"
	exit 0
	;;
-r | --restore)
	check_restore "$2"
	exit 0
	;;
-h | --help)
	help
	exit 0
	;;
-v | --version)
	version
	exit 0
	;;
*)
	echo -e "Try $0 -h' or $0 --help' for more information."
	exit 0
	;;
esac
