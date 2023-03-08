---
title: "Nmap(Network Mapper) For Beginners"
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

{{< admonition type=tip title="-sn Flag" open=false >}}
-sn flag stands for no port scan
{{< /admonition >}}

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
{{< admonition type=warning title="Sudo will not work on windows" open=true >}}
On windows run your terminal as administrator
{{< /admonition >}}

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
{{< admonition type=tip title="Tip" open=true >}}
You can press enter while running a scan to see how much time is left
{{< /admonition >}}

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

