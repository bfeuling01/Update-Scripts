#!/bin/bash

sudo mkdir /usr/local/<name>

sudo chmod 777 /usr/local/<name>

sudo /usr/libexec/PlistBuddy -c "add :Status string Not Provisioned" -c "add :ProvisioningScript string 0.0.0" /usr/local/<name> &&

while true;	do
    myUser=`whoami`
    dockcheck=`ps -ef | grep [/]System/Library/CoreServices/Dock.app/Contents/MacOS/Dock`
    echo "Waiting for file as: ${myUser}"
    sudo echo "Waiting for file as: ${myUser}" >> /var/log/jamf.log
    echo "regenerating dockcheck as ${dockcheck}."

	if [ ! -z "${dockcheck}" ]; then
	    echo "Dockcheck is ${dockcheck}, breaking."
		break
	fi
	sleep 1
done

sudo jamf policy -trigger Provision

exit 0
