Minecraft Server Setup
======================

Quick server configuration tool to help set up a basic Minecraft server's requirements on Ubuntu 14.04 LTS.

If you find these instructions too complicated you might not be up to the task of running your own server and I would recommend you check out any of the GREAT MANY minecraft server hosting companies out there.

Configuring the server with these tools will NOT automatically install Java but it will make installing Oracle Java 7 easy.

After configuring the server with these tools just run:
```
sudo apt-get install oracle-java7-installer
```

Installing Oracle Java 7 requires you to accept their license [http://java.com/license](http://java.com/license).


Using on an existing server
---------------------------

You can use the provided Salt Stack configuration to set up the requirements for running a minecraft server on any existing Ubuntu 14.04 LTS server.

You'll need to install Salt Stack, and copy/link the files from `salt/roots/salt/` to `/srv/salt/`.

Alternatively you can use [https://github.com/lietu-org/salt-init](https://github.com/lietu-org/salt-init)!


Virtual machine
---------------

You can test this out, or set up your own minecraft server in a virtual machine using Vagrant.

You'll need to have Vagrant and VirtualBox installed, after which clone this repository and run the terminal command:
```
vagrant up
```

Ubuntu 14.04 LTS will be downloaded, and configured for use as a minecraft server. 

There is going to be a user on this VM with the username `vagrant` and password `vagrant` with sudo permissions that you can use to manage everything.

The virtual machine will be by default accessible on the IP `172.31.31.31`.

To make this server available outside the computer you're running it on, you need to change the Vagrant networking settings. You'll likely want a "bridged" connection, but this depends on your exact network setup so I'll leave that up to you to figure out. Some documentation on the subject is available at [http://docs.vagrantup.com/v2/networking/public_network.html](http://docs.vagrantup.com/v2/networking/public_network.html).


Installing Minecraft
--------------------

Make sure you install Java before trying to run Minecraft on the server.

This tool only sets up the requirements for running a minecraft server, you can easily run e.g. [Feed The Beast](http://www.feed-the-beast.com/) mod packs or vanilla Minecraft on it after that.

For FTB packs, download the launcher on your desktop and use it to download the server .ZIP file. Extract that in a folder under `/home/minecraft/` on your server and configure `/home/minecraft/start.sh` to run it's `./ServerStart.sh` -script.
 
For Vanilla, you can download the latest server .jar from [https://minecraft.net/download](https://minecraft.net/download) and configure `/home/minecraft/start.sh` to run it as per the instructions on that page.

Then start it up with: `sudo supervisorctl restart minecraft`.

Read the *Other things to take care of* section for more.
 

Managing the server
-------------------

Your minecraft server should be set up with the `minecraft` user, so when installing it, configuring it, etc. you should switch to it first to keep the file permissions correct:
```
sudo su - minecraft
```

The tools in this repository will set up [Supervisor](http://supervisord.org/) to keep the minecraft server running.

To configure what it's running, simply edit `/home/minecraft/start.sh`.

To access the minecraft server's console, stop, start, or restart it, use `supervisorctl`:
```
sudo supervisorctl
```

To access the console use the command `fg minecraft` and press CTRL+C to exit the console.

To start, stop, or restart use the commands `start minecraft`, `stop minecraft` or `restart minecraft`. 

There is a bug in supervisorctl which causes exiting from it to take a fairly long time (tens of seconds) after having accessed the console.


Server backups
--------------

There is a script automagically managing backups set up in cron, however it is disabled by default.

To enable it, edit the file `/home/minecraft/create_backups.sh` and set `ENABLED=1`.

By default the backups are made every 12 hours, if you want to change that, edit the minecraft user's crontab:
```
sudo crontab -u minecraft -e
```

These are basically just "saves" of your server, and not "real backups", so you might want to set up something to copy the backed up saves to a safe location.


Other things to take care of
----------------------------

You'll need to accept the Minecraft EULA before the server will start, to do so edit the `eula.txt` file in your minecraft installation and change the last line to say `eula=true`.

You can change your server's description and a lot of other useful details in the `server.properties` -file in your minecraft installation. This file will be created the first time you start minecraft.

After installing Minecraft, you'll probably want to add yourself as an op. To do that, access the minecraft console in supervisor (`sudo supervisorctl fg minecraft`) and run `op my_minecraft_username` (replace *my_minecraft_username* with yours).

If you want to run a private server, enable the whitelist on the server console:
```
sudo supervisorctl fg minecraft
whitelist on
whitelist add lietu
```

Any publicly available server should have a firewall configured on it. Make sure you configure one, these tools do NOT help with that.


# Financial support

This project has been made possible thanks to [Cocreators](https://cocreators.ee) and [Lietu](https://lietu.net). You can help us continue our open source work by supporting us on [Buy me a coffee](https://www.buymeacoffee.com/cocreators).

[!["Buy Me A Coffee"](https://www.buymeacoffee.com/assets/img/custom_images/orange_img.png)](https://www.buymeacoffee.com/cocreators)
