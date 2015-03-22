#!/bin/bash
export wait=`nohup inotifywait -m -e modify ../conf --exclude ".swp" --format '%f %e %w' -d`
echo $wait
while :
    do
        if [ -z $wait ]; then
            echo nowait
            sleep 5
            else
                echo wait
                sleep 5
        fi

    done