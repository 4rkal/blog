---
title: "Raspberry pi security camera"
date: 2023-02-25T20:03:25+03:00
tags:
- rpi
- selfhosting
---
In this article i will show you how to setup a raspberry pi security camera using motion. In the end of this article you will have a fully functioning security camera with a live feed and motion detection.
# Requirements
1. Raspberry pi or any other computer
2. Web cam
3. Any kind of debian based distro installed on the pi/computer
# Setup
In this article we will be using the motion package (https://motion-project.github.io/)

To get started power on your raspberry pi and ssh into the machine or just connect it to a monitor and a keyboard. Also connect your web cam to the raspberry pi usb port.

The first thing we will have to do is install motion, for that type the following command:\
`apt install motion`\
Now start motion with:\
`systemctl start motion`\
or\
`service motion start`\
Now we are going to change some of the default settings . To do that type:\
`nano /etc/motion/motion.conf`\
The first thing that we are going to change is\
`webcontrol_localhost off`\
This will enable us to access the stream from other computers.

To view the stream run:

`motion` 

If you get a permission denied error try running

`sudo motion`

If you got to http://YOUR_IP:8080 you should see a live feed of the web cam


You can change the port under webcontrol_port in the config file eg.
`webcontrol_port 1234`

If you only want the live stream port you can go to http://your_ip:8081

Again you can change that under stream_port.

Now everything should be working fine. All motion detection files will be saved in /var/lib/motion

You can also change loads of other settings. Here are my settings:https://pastebin.com/WGn0NfcW

Read the documentation here: https://motion-project.github.io/motion_guide.html

***If you enjoyed this article consider {{< link "../../donate" "supporting me" >}}***  

