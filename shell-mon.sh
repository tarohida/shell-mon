#!/bin/sh

MESSAGE_OK='--> \033[32mOK\033[m'
MESSAGE_NG='--> \033[31mNG\033[m'
ACTION_NG='echo NG | mail root@localhost'
CHECK_COMMAND_FILE_PATH='./check_command.txt'
CHECK_INTERVAL=60

# $1: check plugin command
exec_check()
{
    timeout -k 15 10 sh -c "$1"
    if [ $? -eq 0 ]
    then
        echo "${MESSAGE_OK}"
    else
        echo "${MESSAGE_NG}"
        sh -c "${ACTION_NG}"
    fi
}

while true
do
    while read cmd; do
        echo "$cmd"
        exec_check "$cmd"
        echo '-------'
    done < ${CHECK_COMMAND_FILE_PATH}
    sleep ${CHECK_INTERVAL}
done
