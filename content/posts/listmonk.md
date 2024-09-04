---
title: Setup a selfhosted newsletter using listmonk
description: Listmonk is an amazing feature packed selfhosted email newsletter manager. It offers loads of features like analytics (clicks, opens, bounces), templates, public subscription pages, importing subscribers and much more!
date: 2024-08-23T11:19:17+03:00
draft: false
tags:
  - selfhosting
  - automation
  - linux
  - privacy
---
## What is listmonk?
[Listmonk](https://listmonk.app) is a selfhosted newsletter and mailing list manager. It is free and opensource, so you have full control over your data. It also offers a super clean webui:

![Listmonk WebUI](../assets/listmonk.png)

## Listmonk feature overview
1. Analytics - Tracking email opens, link clicks and bounces
2. Templates - Advanced html templates with template variables
3. Public subscription page - See mine [here](https://newsletter.4rkal.com/subscription/form)
4. Subscribers import - Import subscribers from other platforms using CSV.
5. Media Uploads - Upload images etc
6. Email lists - Separate lists eg Weekly roundup and new posts.

And more

## Why choose listmonk over mailchimp, buttodown etc
For me, running a newsletter means owning my email list. 

When people create newsletters they want to break free from the big platforms like Twitter or YouTube. When you use a proprietary service like Mailchimp, you’re still tied down to their rules and limitations. With Listmonk, you get more control and independence, which for me is a huge win. 

The other reason is that listmonk is completely free (if you don't count electricity bills/vps hosting bills). Even if you include the cost of your email host + hosting fees it is still tiny compared to mailchimp or buttondown.

## Requirements for running listmonk
1. A server running linux, either in the cloud or at home. We will be using debian 12, but you can use any other distribution.
2. An email address to send the newsletter from. Can either be a gmail or a custom one.

## Server Setup
Before doing anything I highly recommend that you disable password logins for ssh. See [Securing ssh with Key-Based authentication](https://4rkal.com/posts/sssh/) for more info on how to do that.

Login to your server via ssh

```shell
ssh user@server.ip
```

Make sure that all packages are up to date

```shell
sudo apt update && sudo apt upgrade
```

Create a new directory to host listmonk's configuration files

```shell
mkdir listmonk && cd listmonk
```

Download the listmonk production script (I highly recommend you read scripts before running them)

```shell
sh -c "$(curl -fsSL https://raw.githubusercontent.com/knadh/listmonk/master/install-prod.sh)"
```

Now if you head to 
```
localhost:9000
```

You should see listmonk up and running

But first we should change some settings in the configuration files
```
vim config.toml
```

Here you can change the default admin password. I also changed the address to 0.0.0.0 so that I can access it via the servers ip.

## Listmonk customization

Now head to the webui at 

```
localhost:9000
```

Login and head to the settings

In the `General` tab you can customize the default from email, root url, site name, favicon and admin notification emails

Here's what my settings look like:

![Listmonk Settings](listmonk2.png)

You can customize the page to your liking.

Save by clicking on the save button in the top right corner.

## Email setup
For the next part you will either need a gmail account or any other email provider that give you smtp connection

If you want a great custom email I recommend ionos, you can get up to 10$ in credits by using my link [Ionos - Email & Office 10$ credits ](http://aklam.io/bbxioA) that is the provider that I am currently using. 

In this guide I will show you how to set this up for these two providers, but the setup should be similar for others too.

**IMPORTANT**: Both of these hosts have a limit on how many emails can be sent out per hour or per day. For ionos that is 500/hour. Setting up a [Sliding Window Limit](#sliding-window-limit) is very important.

### Setup for gmail
I recommend that you use a different gmail account from your personal one.

The first thing you will have to do is generate an app password, to do that head to [Create and manage app passwords](https://myaccount.google.com/apppasswords) and create a new one called listmonk. Copy the password that is generated and save it somewhere safe.

Now head over to the listmonk webui

In the `SMTP` tab in settings you will find this:

![Gmail SMTP](../assets/listmonk3.png)

Click on the gmail option as circled.

Now enter your full email address (including @gmail.com) in the username field

And in the password field enter the app password we generated before.

Now click on the `Test connection` button in the bottom right corner, enter a test email and click on `Send e-mail`.

If you configured everything correctly you should now get a test message to the email specified.

Don't forget to save!

### Setup for ionos
You should probably generate a new email for the newsletter, eg `newsletter@yourdomain.tld.

Head over to the listmonk webui

Now in the `SMTP` tab in the settings you see this

![Gmail SMTP](../assets/listmonk4.png)

The ionos smtp server settings are:

Host: `smtp.ionos.com`

Port: `465`

TLS: `SSL/TLS`

**IMPORTANT**: If you’re using IONOS UK or another specific regional version, you need to adjust the host name. For example, if you’re on IONOS UK, you should use `smtp.ionos.co.uk` instead of the global `smtp.ionos.com`.

Now in the username field you should enter the full email address `newsletter@yourdomain.tld` and the password is the normal user password.

Now to test the connection click on the `Test connection` button in the bottom right corner, enter a test email and click on `Send e-mail`.

If you configured everything correctly you should now get a test message to the email specified.

Don't forget to save!

## Sliding window limit
This is very important to setup when email providers limit the amount of email to be sent per hour or per day. You can access the Sliding window limit in `Settings` under the performance tab. For ionos I have it set at 500 emails/hour

## Exposing via cloudflare tunnels
I will be making my instance publicly accessible using cloudflare tunnels.

To do this you will need a cloudflare account and a domain pointed to cloudflare.

First head to the [Zero Trust Dashboard](https://one.dash.cloudflare.com/)

Under `Networks` click on `Tunnels` and then `Create a tunnel`

Once created you should `Install and run a connector`, follow the instructions on the page for your specific setup. 

After the connector is running you should click on the `Public Hostname` tab and `Add a public hostname`.

Now you should see something like this: 
![Zero Trust Dashboard](../assets/listmonk5.png)

Fill in the info as I have. 

The service type should be `HTTP` and the url should be `yourserverurl:9000`, in my case that's 127.0.0.1:9000

Now if you head to the domain that you specified you should see gitea up and running.

In my case you can access my newsletter page [here](https://newsletter.4rkal.com/subscription/form)

## Listmonk feature overview
These are all of the features that listmonk offers:
### Templates
Listmonk offers amazing built in template support. 

All templates are written in HTML.

You can access the templates by going to `Campaigns > Templates`.

Don't forget to always include `{{ template "content" . }}` (for the main content) and also an unsubscribe button in all of your templates
### Campaigns
You can create a new campaign (email) by going to `Campaigns > All Campaigns`

Here you can select a campaign name, subject the list's you want to target and the template
### Email lists
You can create new lists by going to `Lists > All Lists`.

For example I have two lists:
1. New posts - Receive an email every time I post something new on my blog
2. Weekly Roundup - Join my weekly roundup, where I share what I’ve been up to that week, including articles I’ve published, cool finds, tips and tricks and more!

Not everyone wants to receive an email every time I post a new article, so I created two lists!

### HTML Forms
Listmonk also offers embeddable html forms, to subscribe to the email list. You can access the form builder by going to `Lists > Forms`

### Public subscription page
Except for the HTML forms listmonk also has a public subscription page. For example [here](https://newsletter.4rkal.com/subscription/form) is mine. 

It can also be accessed under `Lists > Forms

### Campaign analytics
You can track the views, clicks and bounces of your email campaigns by going to `Campaigns > Analytics`. 

### Import subscribers
You can import subscribers from other platforms by going to `Subscribers > Import`. It currently supports CSV or ZIP files. 


These are the most important features that listmonk offers (I'm sure I forgot some).

## That's all folks

If this article helped you out, consider joining my **newsletter bellow**:


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





















