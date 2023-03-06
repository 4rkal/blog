---
title: "Setup a tor website (hidden service)"
date: 2023-02-25T20:56:02+03:00
---
In this article i will be showing you how to host your “dark web” aka Tor website for free.

# What is Tor?
Tor — short for the Onion Routing project — is an open-source privacy network that enables anonymous web browsing. The worldwide Tor computer network uses secure, encrypted protocols to ensure that users’ online privacy is protected. Tor users’ digital data and communications are shielded using a layered approach that resembles the nested layers of an onion.

# Why use Tor?
Tor is useful for anyone who wants to keep their internet activities out of the hands of advertisers, ISPs, and websites. That includes people getting around censorship restrictions in their country, people looking to hide their IP address, or anyone else who doesn’t want their browsing habits linked to them.

The Tor network may also host webpages that only other Tor users can view. In other words, you’ve entered the Dark Web, which consists of websites that aren’t indexed by the standard crawlers you use to look for products to purchase, and quiz answers etc . On the Dark Web, you can discover everything from free textbooks to drugs — and worse — as long as you know the secret URL that leads to these sites.

# Tor Websites
Just like any other website, you will need to know the address of an onion service in order to connect to it. An onion address is a string of 56 mostly random letters and numbers, followed by “.onion”.

# Requirements
1. A linux machine (debian preferably)
2. An internet connection (pretty hard without one,trust me)

# Installation

The first thing we will have to do is install Tor

`apt install tor`

Now we will have to enable tor hidden service(which is the website) for that type:

`sudo nano /etc/tor/torrc`

You should see a large configuration file, search for `HiddenService`

You will have to uncoment:
```
#HiddenServiceDir /var/lib/tor/hidden_service/
#HiddenServicePort 80 127.0.0.1:80
```
Now press cntrl s and then cntrl x to exit

After that start the tor service by running

`sudo service tor start`

or 

`sudo systemctl start tor`

Now we also have to install nginx to be able to run our website to do that type

`sudo apt install nginx`

Start the nginx service with the systemctl or service command


Now we also have to install nginx to be able to run our website to do that type

`sudo cat /var/lib/tor/hidden_service/hostname`

You should see a address that looks something like this

`tiur7p652svsaemdewbsxnnkrj3b35ny2rx454od5wk5ivfqhijm2qd.onion`

Now open your tor browser and paste your address and press enter. 

You will most probably be greeted by the default nginx site.

This page is easily customized, you can check out my article: 
[here]({{< ref "posts/shwebsite" >}})

GG you did it you are now running a pretty anonymous website on the tor network.
