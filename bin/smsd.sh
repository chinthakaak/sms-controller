#!/bin/bash
projectpath=/data/titanium/svn_projects/iot/smsmodule
. $projectpath/conf/mods.properties

#gammu-smsd -c $smsdrc -d

nohup gammu-smsd -c $smsdrc >/dev/null 2>&1 &

#gammu-smsd -c $smsdrc
