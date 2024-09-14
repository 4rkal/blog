---
title: Nmap(Network Mapper) For Beginners
date: 2023-03-05T17:37:03+03:00
tags:
  - nmap
  - networking
---
Whether you want to scan your network for vulnerabilities or just want to see which ports you have open, nmap can be extremely useful.
# What is nmap
Nmap (Network Mapper) is a network scanner created by Gordon Lyon . Nmap sends packets and examines the answers to find hosts and services on a computer network. For probing computer networks, Nmap offers a variety of functionalities, including host discovery, service detection, and operating system detection. Scripts that offer more sophisticated service discovery, vulnerability detection, and other features can extend these features. During a scan, Nmap can adjust to changing network conditions, such as latency and congestion.

# Installation
Nmap is available for linux, windows , mac os and even bsd

If you are using linux you can install it using your package manager.

On apt

`sudo apt install nmap`

On dnf

`sudo dnf install nmap`

With pacman

`sudo pacman -S nmap`

On windows you have to download the executable from the nmap website.

https://nmap.org/download.html

The same goes for mac and any other os

# Getting Started 
The first thing I will show you how to do is find all the ip addresses connected to your local network.

The first thing you will have to do is find your inet ip

On Linux type

`ip a`

On windows

`ipconfig`

You should see a lot of information, try to find inet. It should look something like this

`inet 192.168.1.28/24`

and copy the ip

Now type

`nmap -sn IP`

Instead of ip type the ip we found from above

Now you should see a large list of all the ips connected to your network.

-sn flag stands for no port scan

Now we can also get all the ports open on all the ips on your local network

To do that type

`nmap IP`

Instead of ip type the ip we found from above

Now if you have any computers on your local networks with open ports you should see them now

Eg.

I have a ssh port open on one of my machines so I can see

```
PORT   STATE SERVICE
22/tcp open  ssh
```
If you are running a web server ports 80 and 443 should be open.

Now lets say that you want to find out what operating system a specified device on your network is running.

To do that type

`sudo nmap -O IP`

Eg. 

`sudo nmap -O 192.168.1.16`

In my case my device is running linux and you can even find out what kernel version your device is running

```
PORT   STATE SERVICE
22/tcp open  ssh
Device type: general purpose
Running: Linux 2.6.X
OS CPE: cpe:/o:linux:linux_kernel:2.6.32
OS details: Linux 2.6.32
```

You can press enter while running a scan to see how much time is left


Lets say that you dont want anyone monitoring a network be able to trace back the scan to you.

For that we can use decoy mode

To use decoy mode add -D followed by any random ip to any nmap command.

eg

`sudo nmap -D 192.168.1.11 192.168.1.16`

This will make it so that it looks like both your ip and 192.168.1.11 are performing a port scan on 192.168.1.16

You can also add multiple ips by adding commas

eg

`sudo nmap -D 192.168.1.11,192.168.1.12 192.168.1.16`

Thats all for now

**GG** You have now learnt the basics of nmap
***If you enjoyed this article consider [supporting me](../../donate)

<div style="text-align: left; margin: 0 auto;">
    <form method="post" action="https://newsletter.4rkal.com/subscription/form" style="background: #2c2c2c; color: #f0f0f0; border-radius: 8px; padding: 15px; max-width: 500px; box-shadow: 0 3px 6px rgba(0, 0, 0, 0.2); font-family: Arial, sans-serif;">
        <div style="display: flex; flex-direction: column; gap: 10px;">
            <h3 style="margin: 0; color: #f0f0f0; font-size: 18px;">Subscribe</h3>
            <input type="hidden" name="nonce"/>
            <input type="email" name="email" required placeholder="E-mail" style="width: 100%; padding: 10px; border: 1px solid #666; border-radius: 4px; background: #333; color: #f0f0f0; box-sizing: border-box;"/>
            <div style="display: flex; flex-direction: column; gap: 8px;">
                <label style="margin: 0; color: #f0f0f0; display: none;">
                    <input id="78a75" type="checkbox" name="l" checked value="78a75b30-472d-4790-a5d5-7f2ed49662a4" style="accent-color: #fff;"/>
                    Weekly Roundup
                </label>
                <span style="color: #d0d0d0; display: none;">Where I share what I’ve been up to that week, including articles I’ve published, cool finds, tips and tricks, and more!</span>
                <label style="margin: 0; color: #f0f0f0; display: none;">
                    <input id="b3964" type="checkbox" name="l" checked value="b3964560-37b0-43d3-9df9-26589fd6bf8d" style="accent-color: #fff;"/>
                    New Posts
                </label>
                <span style="color: #d0d0d0; display: none;">Receive an email every time I post something new on my blog</span>
            </div>
            <input type="submit" value="Subscribe" style="width: 100%; padding: 10px; border: none; border-radius: 4px; background: #fff; color: #007bff; font-size: 14px; cursor: pointer; transition: background-color 0.3s ease, box-shadow 0.3s ease; box-shadow: 0 1px 3px rgba(0, 0, 0, 0.2);"/>
        </div>
        <p style="text-align: center; margin-top: 10px; color: #d0d0d0; font-size: 10px; margin-bottom:0px;">
            No spam, no ads. Unsubscribe at any time.
        </p>
    </form>
</div>