!/bin/bash
clear
START_EXE=`date`
#------------ENVIRONMENT VARIABLE-----------------------------#
CURR_PATH=`pwd`
LOG_FILE_NAME=cleanup.log
LOG_PATH=$HOME
# Today's date in a specific format(same as `date` but without GMT
DATE_1=`date +%b" "%d" "%T" "%Y`
MONTH_1=`date +%b" "%d`
DT=`date +%d`
# To get the recent text with the today's date and also to get the exact string pattern
STRING1=`cat $LOG_PATH/$LOG_FILE_NAME | grep "$MONTH_1" | head -1 | cut -d" " -f7,8,9,10,11`
# To get the 3 months old month (date might not be correct so that today's date only is considered)
DATE_2=`perl -e 'print scalar localtime (time -90 * 86400),"\n"'`
MONTH_2=`echo $DATE_2 | cut -d" " -f2`
# To get the 3 months old MONTH name & add today's date
TEMP2=`echo $MONTH_2" "$DT`
# To get the latest text with the 3months old date and also to get the exact string pattern
TOTAL=`cat $LOG_FILE_NAME | wc -l`
LINE=`cat $LOG_FILE_NAME | grep -n "$MONTH_2" | head -1 | cut -d":" -f1`
echo "Total no. of lines are $TOTAL"
echo "Search string line location $LINE"
FILE=`expr $TOTAL "-" $LINE`
cat $LOG_FILE_NAME | tail $FILE >output.log

#-------------------------------------------------------------#
END_EXE=`date`
echo "SCRIPT EXECUTION STARTED ON :"$START_EXE
echo "SCRIPT EXECUTION ENDED   ON :"$END_EXE
