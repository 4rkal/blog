---
title: Ultimate Monero ColdStorage Guide (Feather X Anonero)
date: 2023-12-14T21:00:30+03:00
description: In this comprehensive guide, I will walk you through the process of easily setting up Monero cold storage using an old computer and your smartphone, using animated QR codes. No USB needed!
tags:
  - "crypto"
---

In this comprehensive guide, I will walk you through the process of easily setting up Monero cold storage using an old computer and your smartphone, using animated QR codes. No USB needed!


## Requirements
1. An old laptop/computer with a webcam (to be kept offline). Called **offline** or **cold** computer.
2. An android smartphone.
3. Your main computer

## Required reads 
Before starting this article you **must** read:
1. [Key concepts](https://malvarma.org/before_we_start/what_things_mean.html)
2. [Monero offline transaction signing details](https://monero.stackexchange.com/questions/2426/offline-transaction-signing-what-are-the-details)
## Cold computer setup

Your offline computer/laptop will be signing all of the transactions. It should always be kept offline i.e cold. It can not be used for other tasks.

I highly recommend that you use a linux distribution and NOT windows for cold storage. Linux is free and opensource. I highly recommend pepermintOS or MX linux as they are lightweight and pretty easy to setup. 

I will not be guiding you on how to install [[linux]]. But here are some resourses to help you get started:

- [Installing PeperMintOS](https://peppermintos.com/guide/downloading/) <--  somewhat 32 bit support, lightweight

- [Installing LinuxMint](https://linuxmint-installation-guide.readthedocs.io/en/latest/install.html) <-- better for newer computers

- [Installing MX Linux](https://www.makeuseof.com/how-to-install-mx-linux/) <-- 32 bit support, pretty lightweight

### Downloading & Installing necessary software

The first thing that we will need to do is download the required software.

We will need [featherwallet](https://featherwallet.org)

and that's about it.

### Taking the device offline

It is highly recommended that you disable the wifi and bluetooth modules on your cold computer. This can be by physically detaching the wifi and bluetooth module or disabling it in the bios. The later is less secure if you're going full on [tinfoilhat](https://i.imgur.com/p5h6STu.jpeg). 

Here's a guide on how to physically disable them from [malvarma.org](https://malvarma.org/cold_wallet/prepare_the_hardware.html)

A guide on how to disable it via BIOS can be found by searching your specific hardware on your [favorite search engine](https://searx.org/). 

### Computer cold wallet setup

Now we will have to setup our wallet. Ensure that your device is completely **offline** and then open featherwallet.

1. Click on `Create a new wallet`. Then click on `Next`. You will be presented with your seedphrase. **Write it down!! on physical paper**. 
2. Select a name for your wallet and click `Next`
3. Select a wallet password and click `Next`.
4. Now that the wallet is open in the bottom right corner there will be a dot. Click on it and select the offline box and then click `Disable all network connections (offline)`


## Phone

We will now be installing the anonero software. We will be using NERO from the ANON/NERO suite.
1. Download and install fdroid. Apk can be downloaded from the [F-Droid website](https://fdroid.org) 
2. Download and install orbot. Can be installed from google play store [here](https://play.google.com/store/apps/details?id=org.torproject.android)
3. Open orbot. Select `VPN Mode`, click on the onion logo that says `start`
4. Open fdroid and in the settings scroll down and enable `Use Tor` option
5. Again in the settings that click on the repositories section and add the following:

    `http://anonero5wmhraxqsvzq2ncgptq6gq45qoto6fnkfwughfl4gbt44swad.onion/fdroid/repo?fingerprint=C5705FF724538F6925B6093517F53C6C6BB6CF82518ED40EB4B8CBBB87DC0D1D`

    Source: [anonero.io](https://anonero.io)
6. Click on  latest and then search for NERO
7. Click on install
That's it ; )

### Updating NERO

If you want to update NERO you will have to turn orbot on, open fdroid and refresh the updates tab

### NERO setup
To set up NERO, follow these steps:

1. Once NERO is successfully installed, open the application.

2. Click on `RESTORE WALLET` option and select `RESTORE FROM KEYS`

3. Proceed to establish a node connection. You can find a lot of Monero nodes [here](https://monero.fail).

   Random clearnet node:
   - `http://xmr.monopolymoney.eu:18089`

   Random Tor node:
   - `http://xmrsalty4hg7lq5ci4kzc2xxcic57azapolbunmkiypnmr3wp7uvqnyd.onion:18089`

  Copy the node address into the node field. By default you shouldn't need a username or password 

  By default tor connectivity is enabled in NERO. You can disable it by going into the proxy settings and deleting everything.

4. Click on `Connect`. It will try connecting. If it fails check your internet connection or try another node 

### Importing view-only wallet

Now you will have to import your wallets `Primary address` , `Secret-View key` and `Restore height` into NERO. To import that info to nero:

On your offline computer open featherwallet and navigate to `Wallet` then `View-Only`. Enter your password and click on the `Show QR`

Now in nero in the View only keys screen click on the square icon to scan the qr. Then scan the qr displayed by featherwallet. All the info should be filled in after scanning the qr code. Click `Next`.

Set a pin. After that your wallet should be imported into NERO.

## Receiving monero
To receive monero you can follow these steps
1. Open NERO and enter your pin
2. Click on the receive tab (the one with the qr code icon)
3. Long hold on the address
4. Select one of the SubAddreses and click on the copy icon.
5. Transfer any amount of monero to that address.

After 10 confirmations it should be spendable. Proceed to the next step.

## Signing transactions

Signing/Broadcasting transactions is easy with the NERO/Feather duo. No usbs are needed it is all done via animated QR codes.

To sign/broadcast a transaction follow these steps
On your phone:
1. Open NERO and enter your pin
2. In the send tab enter the desired address and amount 
3. Click on continue, you should now see an animated QR code.

On your cold computer
1. Open feather and enter your password
2. Click on `Tools` > `Offline transaction signing`. You should now see your camera
3. Show your phone to the computers camera so that it can read the QR code.
4. After it has been picked up by your computer you should see a QR code displayed on your computers screen

In NERO.
1. Click on `SCAN KEY IMAGES`
2. Scan the QR code from the computer's screen 
3. Once it has been picked up you can see the `Address`, `Amount`, `Fee` and `Total`. Click on `confirm`
4. You should now see the unsigned TX screen.

In feather click on `Next`. Then scan the QR code displayed by NERO to your computer. Once the bar is at 100%, you should again see the `Address`, `Amount`, `Fee` and `Total`. If your ok with that click on SIGN.

In NERO
1. Click on `SCAN SIGNED TX`
2. Scan the QR displayed by feather wallet.
3. Click on `Yes`, once asked whether or not to broadcast transaction

You have now sent the transaction.

**if this article helped you out consider [supporting me](https://4rkal.com/donate)**

