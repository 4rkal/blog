---
title: SSH Remote Access NO Port-Forwarding NO Cloudflare
date: 2023-10-04T19:17:04+03:00
draft: false
tags:
  - "ssh"
  - "linux"
---
In this article I will show you how I securely connect to my remote machines without having to configure port forwarding.

## Requirements:
1. A computer "server" (running linux)
2. A internet connection
3. Another computer to connect to your server (running linux)

## Why?
If you want to access your server without portforwarding in a extremely secure fashion you will want to follow this tutorial. You will be connecting to the server via tor which will make it harder for anyone to find the url of the server and ill show you how to setup keybased auth for even more security!

## Setup
You will have to install the following packages (ssh, tor)

On debian

`sudo apt install openssh-client`

On arch

`sudo pacman -S openssh`

After that enable the ssh service

Debian:

`sudo systemctl enable ssh`

Arch:

`sudo systemctl enable sshd`

If you want to check if this worked just use another computer and run

`ssh USER@IP`

for example I run

`ssh arkal@192.168.1.69`

After this you can enable KeyBased authentication for more security

Here is my article how to enable that :

[Enable keybased authentication](https://4rkal.com/posts/sssh/)

Now we need to install tor:

On debian

`sudo apt install tor`

On arch

`sudo pacman -S tor`

Then start and enable the tor service with

`sudo systemctl start tor && sudo systemctl enable tor`

After you have done that you want to edit your torrc file. Using your favorite text editor

`sudo vim /etc/tor/torrc`

Now you will want to navigate to the part that says HiddenService. And paste the following

```
HiddenServiceDir /var/lib/tor/ssh/
HiddenServicePort 22 127.0.0.1:22
```

Save your file and exit the editor (for nano cntrl s, cntrl x)

Now you want will have to restart the tor service

`sudo systemctl restart tor`

After that run the following:

`sudo cat /var/lib/tor/ssh/hostname`

You should see a string of letters and characters ending in .onion 

Now on your other machine:

## Connecting to the server

On your main machine you will have to do the following:

Have ssh, tor, and socat installed

After you have installed them you will have to edit the ssh config

`vim .ssh/config`

And paste the following
```
Host NAME
 Hostname URL.onion
 User USER
 Port 22
 Proxycommand socat - SOCKS4A:127.0.0.1:%h:%p,socksport=9050
```

You will have to change the NAME, URL and USER. The user is the user you want to connect as to your server and the url is the url you that ends in .onion from above.

Now save the file and exit.

Now edit the torrc file. Using your favorite text editor:

`vim /etc/tor/torrc`

Find the line that says SOCKSPort and uncomment it

`SOCKSPort 9050`

Restart the tor service

`systemctl restart tor`

To connect to the server run the following command:

`ssh NAME`

With NAME being the name that you gave to the server in the config file.

**If this article helped you out consider [supporting me](https://4rkal.com/donate)**
