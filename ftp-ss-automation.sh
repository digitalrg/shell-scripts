#!/bin/bash
clear
START_TIME=`date`
#Requirement cd src folder where the binary zip is present
#list all available builds backup
CURR_PATH=`pwd`
SRC_PATH=/opt/tomcat
cd $SRC_PATH
echo "LIST OF BINARY ZIP FILES"
ls -ltr *.zip
#prompt user to select the required build to be deployed
echo "Enter the zip file that needs to be deployed (DONOT ENTER.zip)"
read file
echo "The file you need to deploy is listed below"
ls -ld $file*
# get the details of the destination
echo "ENTER THE IP ADDRESS OF THE DESTINATION:"
read DEST_IP
echo "ENTER THE USER ID OF THE DESTINATION:"
read DEST_USER
echo "ENTER THE PASSWORD:"
stty -echo #Stop the tty so that password is not visible
read DEST_PASS
stty echo
echo "" # force a carriage return to be output
echo You entered $DEST_PASS
clear
# create ftp.txt with the above details
cat >$SRC_PATH/ftp.txt <<START
open $DEST_IP
user $DEST_USER $DEST_PASS
cd $HOME
mkdir deployment
cd deployment
put $HOME/$file.zip $file.zip
cd $HOME
bye
START
#enter the destination location
echo "Copying the file to the destination"
ftp -inv < $SRC_PATH/ftp.txt
#connect to the destination location machine
clear
echo "Logging to the $ip with SSH"
cat >$SRC_PATH/ssh2.txt <<ST
cd $HOME
. ./env.setup # some script to setup the environment variables
rm log.txt
cd deployment
echo "BEFORE UNZIPPING">$HOME/log.txt
ls -ltr>>$HOME/log.txt
/usr/bin/unzip $file.zip
echo "AFTER UNZIPPING">>$HOME/log.txt
ls -ltr>>$HOME/log.txt
MAILTO=XXX.YYY@abc.com
mailx -s "LOG DETAILS" $MAILTO<$HOME/log.txt
rm $HOME/log.txt
exit
ST
SSH_CMD=`echo $DEST_USER@$DEST_IP`
ssh $SSH_CMD <$SRC_PATH/ssh2.txt
rm $SRC_PATH/ftp.txt $SRC_PATH/ssh2.txt
