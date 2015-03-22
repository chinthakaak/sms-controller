#!/bin/bash
projectpath=/data/titanium/svn_projects/iot/smsmodule

. $projectpath/conf/mods.properties

. $projectpath/conf/logs.properties

wrn()
{
	if [ ! -f $loglocation/runonreceivelog ];
		then touch $loglocation/runonreceivelog;
	fi
	if [ $loglevel == "info" ] || [ $loglevel == "warn" ] || [ $loglevel == "error" ] || [ $loglevel == "debug" ];
	  then echo -e "`date +"%Y-%m-%d %T"` [WARN] : $1" |tee -a   $loglocation/runonreceivelog
	fi
}

err()
{
	if [ ! -f $loglocation/runonreceivelog ];
		then touch runonreceivelog;
	fi
	if [ $loglevel == "info" ] || [ $loglevel == "error" ] || [ $loglevel == "debug" ];
	  then echo -e "`date +"%Y-%m-%d %T"` [ERROR] : $1" |tee -a  $loglocation/runonreceivelog
	fi
}

inf()
{
	if [ ! -f $loglocation/runonreceivelog ];
		then touch $loglocation/runonreceivelog;
	fi
	if [ $loglevel == "info" ] || [ $loglevel == "debug" ];
	  then echo -e "`date +"%Y-%m-%d %T"` [INFO] : $1" >>  $loglocation/runonreceivelog
	fi
}

deb()
{
	if [ ! -f $loglocation/runonreceivelog ];
		then touch $loglocation/runonreceivelog;
	fi
	if [ $loglevel == "debug" ];
	  then echo -e "`date +"%Y-%m-%d %T"` [DEBUG] : $1" >> $loglocation/runonreceivelog
	fi
}

# execute latest file in inbox
latestmsgfile=($(ls -t $projectpath/messages/inbox/|head -n1))
inf "Message file is $latestmsgfile"
inf "Phone number is $phonenumber"
ctrlchar='c'

if [[ $latestmsgfile == *"$phonenumber"* ]]
    then
      controlcommands=`cat $projectpath/messages/inbox/$latestmsgfile`
      ctrlarr=(${controlcommands//'|'/ })

      deb "Signal array command type is ${ctrlarr[0]}"

        if [ ${ctrlarr[0]} == $ctrlchar ]
         then
                inf "removing first element from control array"
                unset ctrlarr[$ctrlchar]
                ctrlsignalArr=(  "${ctrlarr[@]}" )
                    for ctrlsignals in "${ctrlsignalArr[@]}";
                    do
                        inf "control signals are ${ctrlsignals}"
                        csig=(${ctrlsignals//,/ })
                                if [[ ${csig[0]}  -ge 0 &&  ${csig[0]} -le 100 ]]
                                    then
                                        inf ${csig[0]}
                                        inf "Starting motor control actions"
                                        ## Motor control
                                        # python -c 'import sys; sys.path.append("'$projectpath'/lib"); import usb; usb.write('$command')' > $projectpath/temp/usb.out

                                        python -c 'import sys; sys.path.append("'$projectpath'/lib"); import piio; piio.write('${csig[0]}')' >> $projectpath/temp/piio.out
                                    else
                                        if [ ${csig[0]} -gt 100 ]
                                            then
                                                inf 'TODO Immergency stop and recovery start'
                                            else
                                                inf 'Null command'
                                        fi

                                fi


                                ## send delay
                                inf "Setting senddelay in mods.properties"
                                if [ ${csig[1]}  -ge 0 ]
                                    then
                                        sed -i 's|^senddelay=.*|senddelay='${csig[1]}'|g' ${projectpath}/conf/mods.properties

                                    else
                                        inf 'Null command'

                                fi


                                ## collection delay
                                inf "Setting collectiondelay in mods.properties"
                                if [ ${csig[2]}  -ge 0 ]
                                    then
                                        sed -i 's|^collectiondelay=.*|collectiondelay='${csig[2]}'|g' ${projectpath}/conf/mods.properties
                                    else
                                        inf 'Null command'

                                fi

                                ## sample size
                                inf "Setting samplesize in mods.properties"
                                if [ ${csig[3]}  -ge 0 ]
                                    then
                                        sed -i 's|^samplesize=.*|samplesize='${csig[3]}'|g' ${projectpath}/conf/mods.properties
                                    else
                                        inf 'Null command'

                                fi
                    done
            else
                inf 'Invalid control command'
        fi


        else
            inf "Invalid SMS is received"
    fi