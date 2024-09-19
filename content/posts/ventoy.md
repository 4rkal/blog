---
title: Create a MultiBoot USB using ventoy
date: 2023-03-06T20:11:51+03:00
tags:
  - linux
---
With ventoy, you don’t need to format the disk over and over, you just need to copy the ISO files to the USB drive and boot them directly.

## Whats ventoy?
Ventoy is a free and open-source utility used for writing image files such as .iso, .wim, .img, .vhd(x), and .efi files onto storage media to create bootable USB flash drives. Once Ventoy is installed onto a USB drive, there is no need to reformat the disk to update it with new installation files; it is enough to copy the .iso to the USB drive and boot from them directly. Ventoy will present the user with a boot menu to select one of these files.

## Requirements
1. a computer
2. a internet connection (pretty hard without one)
3. a usb (min 8gb)

## Installation
Ventoy is available on both linux and windows.

The first thing you will have to do is head to ventoy.net . On the download page select your operating system and click on download.

## On linux
After you have extracted the file open the folder and click on the VentoyGUI .

Depending on your processor type select the file ending in either aarch64 i386 mips64el or x86_64. (It will most probably be x86_64).

After that you should see something like this:
![Ventoy on linux](../assets/ventoy.webp)

Select your device from the devices tab

Then click on install.

## On windows
Download the file and unzip it

Then click on the file called Ventoy2Disk.exe

You should see something like this

![Ventoy on Windows](../assets/ventoy-win.webp)

Select your usb device from the drop down and click on install.

# Using ventoy 
To use ventoy all you have to do is paste your iso files inside of the usb. No formatting etc.

When you boot into your usb you will be prompted which of the iso's to use. That's about it.

Enjoy not having to reformat your usb for each iso/OS

### Join my free newsletter!
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