#!/bin/bash

jarfile="/data/minecraft_server.jar"
propertyfile="/data/server.properties"
eulafile="/data/eula.txt"
version="1.8.8"
maxmemory="1G"
uri="https://s3.amazonaws.com/Minecraft.Download/versions/${version}/minecraft_server.${version}.jar"

if [ ! -f $jarfile ]; then
  curl $uri -o $jarfile
fi

echo "configuring ${propertyfile} ..."

sed -i -e"s/online-mode=.*/online-mode=false/" $propertyfile
sed -i -e"s/eula=.*/eula=true/" $eulafile

# it's necessary for java running at correct ENV
cd /data

java -Xmx${maxmemory} -jar minecraft_server.jar <<EOT
op Micooz
EOT
