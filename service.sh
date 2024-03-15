#!/bin/bash
if [ $# -eq 0 ]; then
    echo "Please pass services to start"
else
    for service in $@; do
        echo '-----------------------------'
        X=$(service $service status | grep -i "running")
        if [ $? -eq 0 ]; then
            echo "Service $service is already running..."
            PORT=$(netstat -ntlp | grep -i $service | head -1 | cut -d ':' -f 2 | awk '{print $1}')
            ProcessID=$(netstat -ntlp | grep -i $service | head -1 | cut -d '/' -f 1 | awk '{print $7}')
            echo "Service $service is listening on $PORT"
            echo "Service $service PID is : $ProcessID"
        else
            service $service start
            PORT=$(netstat -ntlp | grep -i $service | head -1 | cut -d ':' -f 2 | awk '{print $1}')
            ProcessID=$(netstat -ntlp | grep -i $service | head -1 | cut -d '/' -f 1 | awk '{print $7}')
            echo "Service $service started..."
            echo "Service $service is listening on $PORT"
            echo "Service $service PID is : $ProcessID"

        fi
    done
fi

# bash services.sh nginx mysql
# bash services.sh nginx
