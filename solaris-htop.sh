# !/user/bin/sh
# Script to monitor RAM, SWAP, CPU and HDD details
# monitor.sh


# Variables
INTER=5
DISK=/data

# Calculations
DATE=`date +%d-%m-%Y`
TIME=`date +%H:%M:%S`
SIZE=`df -h $DISK | grep  "/data" | awk '{print $2}'`
HOST=`hostname`
REGN=ABCD
RAM=`/usr/sbin/prtconf|grep Memory| cut -f3 -d" "`
USED=`/usr/sbin/swap -s | awk '{print $9}' |sed 's/k/ /'`
AVAIL=`/usr/sbin/swap -s | awk '{print $11}'|sed 's/k/ /'`
TEMP=`expr $USED "+" $AVAIL`
K=1024
SWAP=`expr $TEMP "/" 1024`
#echo "USED $USED AVAIL $AVAIL TEMP $TEMP   SWAP $SWAP Mb"
clear
echo ~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~
echo "Date		:"$DATE		"				Time	:"$TIME
echo "HDD		:"$DISK		"				Size	:"$SIZE"B"
echo "HostName        :"$HOST		"				Region	:"$REGN
echo "RAM		:"$RAM		"MB				Swap	:"$SWAP" MB"
echo ~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~
echo "        MEMORY       |             CPU                |     HDD      |           PROCESS              |"
echo ~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~
echo "SIZE	USED	FREE |	USER	SYS	WAIT	IDLE  |	USED	FREE |	MAIN	TRAN1	TRAN2	TOTAL |"
echo ~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~
# Variables for the looping
M_SIZE=`expr $SWAP "/" 1024`
M_USED=`expr $(/usr/sbin/swap -s | awk '{print $9}' |sed 's/k/ /') "/" 1024`
M_FREE=`expr $(/usr/sbin/swap -s | awk '{print $11}'|sed 's/k/ /') "/" 1024`
C_USER=`iostat -c | awk '/us/{c=1;next}c-->0' | awk '{ print $1}'`
C_SYS=`iostat -c | awk '/us/{c=1;next}c-->0' | awk '{ print $2}'`
C_WAIT=`iostat -c | awk '/us/{c=1;next}c-->0' | awk '{ print $3}'`
C_IDLE=`iostat -c | awk '/us/{c=1;next}c-->0' | awk '{ print $4}'`
H_USED=`df -h $DISK | grep  "/data" | awk '{print $3}'`
H_FREE=`df -h $DISK | grep  "/data" | awk '{print $3}'`


echo "$M_SIZE MB $M_USED MB $M_FREE MB  $C_USER %    $C_SYS %     $C_WAIT %     $C_IDLE %  $H_USED B   $H_FREE B     --  --  --  -- " 
