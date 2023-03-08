---
title: "Get ad free web with Pi-hole"
date: 2023-02-25T21:17:13+03:00
tags:
- rpi
- selfhosting
---
n this article i will show you how to setup pi-hole. Pi-Hole will allow you to block in app ads improve your networks performance and monitor statistics. Pi-hole also allows you to create a vpn.

# What is Pi-hole?
Pi-hole is a Linux network-level advertisement and Internet tracker blocking application which acts as a DNS sinkhole and optionally a DHCP server, intended for use on a private network. It is designed for low-power embedded devices with network capability, such as the Raspberry Pi, but can be installed on any Linux machine. Pi-hole has the ability to block traditional website advertisements as well as advertisements in unconventional places, such as smart TVs and mobile operating system advertisements.

# Requirements
1. A computer with linux (preferably something debian based)
2. Preferably an ethernet cable
3. Access to your routers admin portal
4. A static ip
5. An internet connection (its pretty difficult without one, trust me)

# Installation

The first thing we have to do is download the installer

To do that type

`wget -O basic-install.sh https://install.pi-hole.net`

Now install it with

`sudo bash basic-install.sh`

Now you should see something like this

{{< image src="../assets/pihole/1.webp" caption="">}}

Just press ok

{{< image src="../assets/pihole/2.webp" caption="">}}

Just press ok again

As i said before you have to have a static ip in order to setup the pihole so if you have one configured just press yes

{{< image src="../assets/pihole/3.webp" caption="">}}

Otherwise you will have to set one up.

Now you will be prompted to select your upstream dns provider. You can select any of the dns providers on the list. I will just select google

{{< image src="../assets/pihole/4.webp" caption="">}}

And press ok

After that you will have to select your list. I will just select the default one

{{< image src="../assets/pihole/5.webp" caption="">}}

Now you will have to select whether you want a web admin interface. Select on and then ok

{{< image src="../assets/pihole/6.webp" caption="">}}

Now just select on and press ok

{{< image src="../assets/pihole/7.webp" caption="">}}

After that you can select if you want to log queries. You can select any option you want.

{{< image src="../assets/pihole/8.webp" caption="">}}

Now i recommend that you leave this as default but you don’t have to

{{< image src="../assets/pihole/9.webp" caption="">}}

Now it should start installing everything

After the installation is finished you should see something like this

{{< image src="../assets/pihole/10.webp" caption="">}}

You have now successfully install pi-hole. You can head to the admin portal by going to the specified ip.

To be able to use pi-hole you have 2 options
1. Make the ip default dns for you hole network
2. Manually add it on any device

Ill go with the second option

On windows:

DNS settings are specified in the TCP/IP Properties window for the selected network connection.

1. Go to the Control Panel
2. Click Network and Internet > Network and Sharing Center > Change adapter settings
3. Select the connection for which you want to configure
4. Right-click Local Area Connection > Properties
5. Select the Networking tab
6. Select Internet Protocol Version 4 (TCP/IPv4) or Internet Protocol Version 6 (TCP/IPv6)
7. Click Properties
8. Click Advanced
9. Select the DNS tab
10. Click OK
11. Select Use the following DNS server addresses
12. Replace those addresses with the IP addresses of your Pi
13. Restart the connection you selected in step 3
14. Repeat the procedure for additional network connections you want to change.

On Linux its a lot easier just:
In most modern Linux distributions, DNS settings are configured through Network Manager.

1. Click System > Preferences > Network Connections
2. Select the connection for which you want to configure and press **Edit**
3. Select the IPv4 Settings or IPv6 Settings tab
4. If the selected method is Automatic (DHCP), open the dropdown and select Automatic (DHCP) addresses only instead. If the method is set to something else, do not change it.
5. In the DNS servers field, enter your Pi’s IP addresses
6. Click Apply to save the changes
{{< admonition type=warning title="If you are not using network manager" open=true >}}
Then your DNS settings are specified in `/etc/resolv.conf`

{{< /admonition >}}

(source: pi-hole.net)

Now if we head over to any websites with ads you should see that no ads appear

Lets try speedtest.net

If you have followed the steps correctly you should see something like this

{{< image src="../assets/pihole/ads.webp" caption="No ads!">}}

**NO ADS**

Enjoy the ad free web
