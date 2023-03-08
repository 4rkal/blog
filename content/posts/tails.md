---
title: "Become anonymous and somewhat untraceable with tails os"
date: 2023-03-03T23:03:40+03:00
tags:
- tor
- privacy
---
In this article we will talk about what tails is and how to install and more.

# What is tails?
Tails, or The Amnesic Incognito Live System, is a security-focused Debian-based Linux distribution aimed at preserving privacy and anonymity.It connects to the Internet exclusively through the anonymity network Tor. The system is designed to be booted as a live DVD or live USB, and leaves no digital footprint on the machine unless explicitly told to do so.
# What is the tor network?
Tor, short for The Onion Router, is free and open-source software for enabling anonymous communication. It directs Internet traffic through a free, worldwide, volunteer overlay network, consisting of more than six thousand relays,to conceal a user’s location and usage from anyone performing network surveillance or traffic analysis. Using Tor makes it more difficult to trace a user’s Internet activity.
# Who is tails intended for?
As the tails website states (https://tails.boum.org/). Tails is intended for Activists who use Tails to hide their identities, avoid censorship, and communicate securely. Journalists and their sources use Tails to publish sensitive information and access the Internet from unsafe places. Domestic violence survivors use Tails to escape surveillance at home. You whenever you need extra privacy in this digital world.
# Requirements
1. A computer (minimum of 2GB ram , 64-bit x86–64 compatible processor)
2. A usb stick with 8GB+ of space

{{< admonition type=tip title="Read more" open=true >}}
Read more https://tails.boum.org/doc/about/requirements/index.en.html
{{< /admonition >}}
# Installation
{{< admonition type=warning title="Warning" open=true >}}
Back up all your files USB files as they will get deleted.
{{< /admonition >}}
The first thing you will have to do is to head to https://tails.boum.org/install/index.en.html
Now select your operating system

Ill walk you through the installation for windows and linux.
This should probably bethe same with linux
After you have clicked on the windows logo you should be prompted with the requirements and a step by step guide.

The first thing you will have to do is to download the tails usb image.

After that i highly recommend that you verify your download

Just click on select and select it.

Now you will have to download balena etcher. Just click on download balena etcher and double click the installer.

At this moment plug in your usb (if you have any important files on the usb you have to back the up or they will be lost)

Now click the flash from file button and select the file you downloaded (it ends in .img)

Click the Select target button to select your USB stick.

And now select flash.

This could take a while so just sit back and relax.

# Using tails
After your installation is finished just reboot your computer and hit F12 or F2 depending on your computer.

Now you should see a screen thats says something like please select your boot device. You will have to select your usb and hit enter

Now you should see the grub loader

Select Tails and hit enter

Now you should be booted into tails

You will probably see a screen that looks something like this

{{< image src="../assets/tails.webp" caption="">}}

Here you will have to set your language and region. We can also press on the + icon to add a admin password mac address anonymization etc. I will just put the admin password and the unsafe browser. You can select anything you want. However remember that changing some of these settings will make you less anonymous.

Once you are ready select start tails

Now you will see

{{< image src="../assets/tails2.webp" caption="">}}

Here you can select anything you want. I will just select the first option.

Now you should see this:

{{< image src="../assets/tails3.webp" caption="">}}

GG you did it. One more step though

I like to have a persistent volume so that i don’t lose all my files when i reboot. To do that open the configure persistent volume app and follow the steps there.

That’s it for now



