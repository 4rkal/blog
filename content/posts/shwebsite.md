---
title: "Self host your own website"
date: 2023-02-25T20:23:16+03:00
tags:
- selfhosting
---
In this article i will show you how to self host your own website securely.
# Requirements
1. A computer or microcomputer to host the website
2. The computer needs to run linux 
3. An internet connection (Its pretty hard without one, trust me)

Lets get started!

# Installation 
The first thing that we will have to do is setup our nginx site.

We first have to be root

`sudo su`

If you dont have sudo installed try:

`su -`

Now we will have to install nginx

`apt install nginx`

If you are using any other package manager install it using the package name nginx

Now we will have to start the nginx service

`systemctl start nginx`

or 

`service nginx start`

Lets find your ip with:

`ip a`

or

`ifconfig`

If you open a web browser and go to your ip you should see the default welcome to nginx site.

Since we want to make our website as secure as possible we can hide the nginx version

To do that type

`sudo nano /etc/nginx/nginx.conf

Now you should see the nginx configuration file.

under

```
http {
##
        # Basic Settings
        ##
sendfile on;
        tcp_nopush on;
        types_hash_max_size 2048;
        # server_tokens off;
```
uncomment `server_tokens off;`

Now restart your nginx service

`systemctl restart nginx`

We can now enter our html files inside of `/var/www/html`

To do that type:

`cd /usr/share/nginx/html`

and now we can create the index.html file

`nano index.html`

and paste/write your html code to index.html

Now restart the nginx service again

`systemctl restart nginx`

# Certbot
Now we will install cerbot in order to get https

To install certbot simply type

`apt install certbot python-certbot-nginx`

Now we will have to run certbot

`certbot --nginx`

Enter all the inf oand agree to the terms

After that you will have to enter the name you would like to activate https for

Just select the names

After that select to redirect http to https

# Port forwarding
There are a few ways to port forward. In this article we will use noip.com.

Head over to noip.com to get started (Use my referal https://www.noip.com/?fpr=4rkal)

Create an account and register a hostname

After that we will have to build the noip client on our computer for that paste these commands to your terminal

```
cd /usr/local/src
wget http://www.no-ip.com/client/linux/noip-duc-linux.tar.gz
tar xzf noip-duc-linux.tar.gz
cd noip-2.1.9–1
make
make install
```
When you run make install you will be prompted to answer some questions like your login information and the update interval

In the update interval just set it to 30

Then if you don’t want to run something at a successful update type n if you do then type y.

You will now also have to edit the nginx default settings

to do that type

`sudo nano /etc/nginx/sites-available/default

Now you will have to change the server_name to the domain you registered at noip.com

You can check if your configuration was successful by running

`nginx -t`

You can now restart the nginx service

`systemctl restart nginx`

Now if you head to your domain it should be working and ssl should be installed
