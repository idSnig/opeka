#!/bin/bash
# Script to start the node server for the cfdpchat-app
# authors: Daniel Mois and Benjamin Christensen
# The paths below should be updated to match your server setup.
# The file should then be saved as a new file called startchat
# Make sure the log file is writable by www-data (or the user starting the Forever job)

NODE_BIN_DIR="/usr/local/bin/node"
NODE_PATH="/home/benjamin/workspace/web/node_modules"
APPLICATION_DIRECTORY="/home/benjamin/workspace/web/cfdpchat/nodejs"
APPLICATION_START="main.js"
LOG="/home/benjamin/workspace/web/cfdpchat/logs/forever.log"
PIDFILE="/home/benjamin/workspace/web/cfdpchat/logs/pids.pid"

echo -e "Starting CfDP Chat... \n"

# cd to app home directory
cd $APPLICATION_DIRECTORY
# Add the node executables to the path, which includes Forever if it is
# installed globally, which it should be.
# PATH=$NODE_BIN_DIR:$PATH
# The minUptime and spinSleepTime settings stop Forever from thrashing if
# the application fails immediately on launch. This is generally necessary to
# avoid loading development servers to the point of failure every time
# someone makes an error in application initialization code, or bringing down
# production servers the same way if a database or other critical service
# suddenly becomes inaccessible.
forever --sourceDir $APPLICATION_DIRECTORY -a -l $LOG \
--pidFile $PIDFILE --minUptime 5000 --spinSleepTime 2000 start $APPLICATION_START
