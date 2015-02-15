#!/usr/bin/env bash

export HOME="/home/minecraft"
source "/etc/profile"

# This file is used by Supervisor to manage your Minecraft server
#
# To run your server you need to:
# 1. Change to the correct directory
# 2. In case of a modpack with it's own launch script, run that, OR in case
#    there is no launch script or running Vanilla run java with the correct
#    arguments.

# This is an example to run the vanilla minecraft server if
# installed in /home/minecraft/server/minecraft_server.jar

cd "$HOME/server"
java -Xmx1024M -Xms1024M -jar minecraft_server.jar nogui
