#!/bin/bash
projectpath=/data/titanium/svn_projects/iot/smsmodule

nohup $projectpath/bin/runonreceiveslave.sh >/dev/null 2>&1 &

kill -9 `ps -ef|grep injectord.sh |awk '{print $2}'`
sleep 10
nohup $projectpath/bin/injectord.sh >/dev/null 2>&1 &

