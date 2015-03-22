#!/bin/bash
. conf/mods.properties

. $projectpath/conf/logs.properties

wrn()
{
	if [ ! -f $loglocation/injectordlog ];
		then touch $loglocation/injectordlog;
	fi
	if [ $loglevel == "info" ] || [ $loglevel == "warn" ] || [ $loglevel == "error" ] || [ $loglevel == "debug" ];
	  then echo -e "`date +"%Y-%m-%d %T"` [WARN] : $1" |tee -a   $loglocation/injectordlog
	fi
}

err()
{
	if [ ! -f $loglocation/injectordlog ];
		then touch injectordlog;
	fi
	if [ $loglevel == "info" ] || [ $loglevel == "error" ] || [ $loglevel == "debug" ];
	  then echo -e "`date +"%Y-%m-%d %T"` [ERROR] : $1" |tee -a  $loglocation/injectordlog
	fi
}

inf()
{
	if [ ! -f $loglocation/injectordlog ];
		then touch $loglocation/injectordlog;
	fi
	if [ $loglevel == "info" ] || [ $loglevel == "debug" ];
	  then echo -e "`date +"%Y-%m-%d %T"` [INFO] : $1" >>  $loglocation/injectordlog
	fi
}

deb()
{
	if [ ! -f $loglocation/injectordlog ];
		then touch $loglocation/injectordlog;
	fi
	if [ $loglevel == "debug" ];
	  then echo -e "`date +"%Y-%m-%d %T"` [DEBUG] : $1" >> $loglocation/injectordlog
	fi
}


while :
    do
        . conf/mods.properties
        sampledelay=$(( $senddelay - $collectiondelay * $samplesize ))
        inf "Waiting for $sampledelay seconds as sample delay"
        sleep $sampledelay

        for ((i=0 ; i<$samplesize; ++i));
            do
                if [ $i == 0 ]
                 then separator='d|'
                 else separator='|'
                fi

                nsample=`python -c 'import sys; sys.path.append("lib"); import piio; print piio.read()'`
                timestamp=`date +"%Y-%m-%d %T"`
                nsample=$separator''$timestamp','$nsample''
                deb " collected sample is $nsample"
                samples+=$nsample
                inf "Waiting for $collectiondelay seconds as collectiondelay"
                sleep $collectiondelay
            done
        deb "All samples are $samples"

        msglength=${#samples}
        gammu-smsd-inject -c $smsdrc  TEXT $phonenumber -text "$samples" -len $msglength

        samples=''

    done
