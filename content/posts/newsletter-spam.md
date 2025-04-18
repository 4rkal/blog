---
title: Prevent newsletter signup spam
description: Got spammed with fake newsletter signups? Learn how to protect your forms using double opt-in, CAPTCHA, and Cloudflare.
date: 2025-04-17T17:43:47+03:00
draft: false
---
## Backstory

I woke up to 200 new subscribers on the newsletter of my site [videiro.com](https;//videiro.com), had it finally happened? Did my site finally go viral?

Sadly no. After checking the new subscribers I noticed that none had verified their email addresses, not even one, that's definitely not a confidence. 

After some quick research I understood that I had indeed been spammed. But all the emails look legit. Here are some examples:
```
kathyolynn@yahoo.com
lukeckins@gmail.com
dispatch@gonealinc.com
doug_fern@hotmail.com
```

After some initial research (entering the emails into [haveibeenpwned](https://haveibeenpwned.com/)) it looks like most of these email addresses have been in some kind of hack or breach. 

So what was happening? How can I prevent it in the future?

Someone, decided to use compromised email addresses to spam my form. Either to pollute my newsletter, to see how far they could go or just because they can?

## What I learned
When making anything publicly available on the internet, there will be spammers, there will be bots and there will be people trying to hack it. That is why you should always be making it as secure as possible. 

It turns out that this kind of spam attack is more common that you think (especially since my [blog's newsletter](https://newsletter.4rkal.com) also got spammed a couple weeks later). Bots crawl the web and look for forms, usually newsletter or contact forms and then start submitting "leaked" email addresses. 

But why?
Here are some reasons I came up with:
- To pollute your email list (if this is a personal attack, which I don't think it is in this case)
- To test the validity of the emails?? 
- To annoy the leaked email addresses owners by having them subscribed to thousands of newsletters
- To annoy the website owner (me)

## How I fixed it
I have a couple solutions to this problem.
### Step 1: Enable Double Opt-in
The fist and most important step is to make sure that all your newsletters are 'double opt-in' meaning that the user has to confirm their email address before getting subscribed

On listmonk (the newsletter software I am using) make sure that the list that you are subscribing your users to is `double opt in`

This means that even if your form gets spammed you can just remove all the addresses that haven't verified their email (after a couple of days/weeks).

Want to learn how to set up your own self-hosted newsletter with Listmonk?  
Check out my guide: [How to set up a self-hosted newsletter using Listmonk](https://4rkal.com/posts/listmonk/)

### Step 2: Add Captcha or Cloudflare JS challenge
The second step I took was to enable some sort of catcha. Initially I setup an hcaptcha via listmonk. But I don't think that is the best solution as it's kind of annoying. I am however using it for the [videiro.com](https://videiro.com) newsletter.
If your interested in how to do it here's how:
1. Open the listmonk web-ui
2. Go to settings
3. Under `Security`, enable captcha and enter an hCaptcha.com API key (you will first have to signup at [hcaptcha.com](https://hcaptcha.com))

However with this setup if you are using custom forms (like the email subscription form bellow) the submission process will be kind of broken. 

So instead what I came up with and I am currently using on [4rkal.com](https://4rkal.com) newsletter is to use cloudflare JS Challenge on a specific subdomain.

The way that I have setup my email newsletter is that I have listmonk running on `newsletter.4rkal.com`, a seperate subdomain.

This means that I can set that specific subdomain as "under attack" on cloudflare and prompt users to sometimes complete a catcha. 

To do this:
1. Head to cloudflare.com
2. Login and head to the dashboard of your specific domain
3. Under `Security` select `WAF`
4. Then click on `Create rule`
5. Give it any name
6. Under `Field` select `hostname` and under `Operator` select `wildcard`, in `Value` enter the subdomain, in my case that's `newsletter.4rkal.com`. The expression should look like this `(http.host wildcard "newsletter.4rkal.com")`
7. Under `Choose action` select `JS Challenge`
8. Click on `Save`

And that's about it

## Summary
Getting your website spammed is never fun, but I hope this article might have given clarity to people going through the same problem as me.

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

