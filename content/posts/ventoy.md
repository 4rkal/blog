---
title: "Create a MultiBoot USB using ventoy"
date: 2023-03-06T20:11:51+03:00
---
With ventoy, you don’t need to format the disk over and over, you just need to copy the ISO files to the USB drive and boot them directly.

# Whats ventoy?
Ventoy is a free and open-source utility used for writing image files such as .iso, .wim, .img, .vhd(x), and .efi files onto storage media to create bootable USB flash drives. Once Ventoy is installed onto a USB drive, there is no need to reformat the disk to update it with new installation files; it is enough to copy the .iso to the USB drive and boot from them directly. Ventoy will present the user with a boot menu to select one of these files.

# Requirements
1. a computer
2. a internet connection (pretty hard without one)
3. a usb (min 8gb)

# Installation
Ventoy is available on both linux and windows.

The first thing you will have to do is head to ventoy.net . On the download page select your operating system and click on download.

# On linux
After you have extracted the file open the folder and click on the VentoyGUI .

Depending on your processor type select the file ending in either aarch64 i386 mips64el or x86_64. (It will most probably be x86_64).

After that you should see something like this:
{{< image src="../assets/ventoy.webp" caption="">}}

Select your device from the devices tab

Then click on install.

# On windows
Download the file and unzip it

Then click on the file called Ventoy2Disk.exe

You should see something like this

{{< image src="../assets/ventoy-win.webp" caption="">}}

Select your usb device from the drop down and click on install.

# Using ventoy 
To use ventoy all you have to do is paste your iso files inside of the usb. No formatting etc.

**GG** you have now installed ventoy
