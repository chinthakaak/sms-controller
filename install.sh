#!/bin/bash

projectpath=`pwd`

echo 'Installing SMS Module at '${projectpath}''
echo 'Updating... smsdrc'
sed -i 's|^runonreceive = .*|runonreceive = '${projectpath}'\/bin\/runonreceive.sh|g' ./conf/smsdrc
echo 'Updating... runonreceive'
sed -i 's|^projectpath=.*|projectpath='${projectpath}'|g' ./bin/runonreceive.sh
echo 'Updating... runonreceiveslave'
sed -i 's|^projectpath=.*|projectpath='${projectpath}'|g' ./bin/runonreceiveslave.sh
echo 'Updating... startup'
sed -i 's|^projectpath=.*|projectpath='${projectpath}'|g' ./startup.sh
echo 'Updating... smsd'
sed -i 's|^projectpath=.*|projectpath='${projectpath}'|g' ./bin/smsd.sh

echo 'Setting up project path...'
sed -i 's|^projectpath=.*|projectpath='${projectpath}'|g' ./conf/mods.properties

echo "Setting up logging..."
sed -i 's|^loglocation=.*|loglocation='${projectpath}'\/logs|g' ./conf/logs.properties

echo
echo 'Setting required permissions ....'
chmod +x ./bin/injectord.sh ./bin/runonreceive.sh ./bin/runonreceiveslave.sh ./bin/smsd.sh ./startup.sh ./shutdown.sh ./restart.sh
echo 'Installation completed successfully'