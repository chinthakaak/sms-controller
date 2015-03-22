#!/bin/bash
projectpath=/data/titanium/svn_projects/iot/smsmodule
if [ -f ~/.profile ]
    then
    source ~/.profile
fi
$projectpath/bin/smsd.sh
nohup $projectpath/bin/injectord.sh >/dev/null 2>&1 &