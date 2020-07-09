#!/bin/sh
while true
do
    while read cmd; do
        echo "$cmd"
        timeout -k 15 10 sh -c "$cmd"
        if [ $? -eq 0 ]
        then
            echo "OK"
        else
            echo "NG"
            echo 'NG' | mail root@localhost
        fi
    done < check_command.txt
    sleep 1
done
