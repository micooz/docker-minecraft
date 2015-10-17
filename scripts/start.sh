#!/bin/bash

jarfile="/data/minecraft_server.jar"
version="1.8.8"
maxmemory="1G"
uri="https://s3.amazonaws.com/Minecraft.Download/versions/${version}/minecraft_server.${version}.jar"

if [ ! -f $jarfile ]; then
  curl $uri -o $jarfile
fi

java -Xmx${maxmemory} -jar $jarfile nogui