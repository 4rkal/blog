---
title: Easy monero cold storage
date: 2023-11-07T18:03:15+02:00
tags:
  - "crypto"
---

In this article I will show you how to "easily" generate a live archlinux usb with the monero gui pre-installed.

## Requirements

1. An arch[[linux]] install 
2. A usb

## Setup
In this guide I will show you how to build a custom archlinux iso with monerogui installed. I will not be providing any pre-built images.

The first thing you will have to do is install [archuseriso](https://github.com/laurent85v/archuseriso). You can install it from the aur using this command:

`yay -S archuseriso`

Now open a terminal and navigate to any directory. Then run the following command:

`sudo aui-mkiso -m 'img' --add-pkg=monero-gui xfce --verbose`

This will build a new gpt image with persistense, add the monero-gui package and use xfce as the default desktop. The --verbose flag is optional.

After that is finished building you can use your favourite image writter to write the image. I will be using dd 
`sudo dd if=out/aui-xfce*.img of=/dev/CHANGEME`

You will have to write that to your usb, so in /dev/CHANGEME just put your usb. You can find it by running `lsblk`
**Don't be stupid**
If you enter the wrong device this could lead to data loss. Be careful!

After the image is written you will have to boot to your usb. 

First however it is recommended that you disconnect any ethernet/other cables plugged in so that it is trully offline.

You can also [disable wifi and bluetooth from the bios](https://www.google.com/search?q=disable+wifi+and+bluetooth+bios) . "Advanced" users only don't be retarded

Now only plug in your usb drive and reboot into the usb. You will generaly have to press either F8,F9,F10,F11 upon booting and then select your usb.

Now you have two options
1. Boot into persistent.
2. Boot into memory. 

When booting into persistent your files will be saved. This however does also involve your wallet file. 

For the more secure option you can select boot into memory. This will delete all the traces of the wallet after reboot. You will have to write the seed down and manually enter it upon every boot if you want to authorize transactions. 

I will boot into persistent since I will use a strong password and will keep the usb in a safe place. If you want to be extra paranoid use the second option.

After the os has fully booted you will have to click on the `Applications` icon > internet > `Monero GUI`. Alternatively open a terminal and type `monero-wallet-gui`

You will now be greated by the monero gui setup guide.

Select your language etc. 

Select advanced > Click on `Create a new wallet` . You can select whatever you want in the wallet name and location > Click next.

Now you will be prompted with your recovery phrase. Write it down on PHYSICAL PAPER and keep it in a safe place. Also note the height and or creation date.

Write it down!
If you don't write down your seed and keep it in a secure place you will lose access to your monero!

Then click next. Now select a strong password. Alteast 12 chars!. Remeber it!

Click next. Then click on `Connect to a remote node` but don't add one, we don't need it.

Then click on create wallet.

After you have opened your wallet, click on `settings` and then `Create view-only wallet`. Then click on ok. Logout of your wallet. Click on `Open wallet from file` and select the new file called WALLETNAME_viewonly.

Once you have logged into your view only wallet click on settings again and select `Show seeds and keys`. Scroll down to the botton and import your view only wallet via qr to your mobile wallet. Here are some guides for every wallet:

- [Cake wallet](https://guides.cakewallet.com/docs/basic-features/restore-wallet-from-qr-code/)
- [Monerujo](https://www.monerujo.io/resources/monerujo_manual.html)

## What have we acomplished?

You now have a cold wallet for offline signing on your usb and a view-only wallet on your phone. Basicly you can view all incoming transactions on your phone but can't spend them there. Only your computer booted into the usb can sign them.

## Signing transactions

I won't cover doing this in this article. But you can find out more about how to send transactions from cold storage [here](https://monerodocs.org/cold-storage/offline-transaction-signing/)