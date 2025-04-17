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
If your interested in how to do it here how:
1. Open the listmonk web-ui
2. Go to settings
3. Under `Security`, enable captcha and enter an hCaptcha.com API key (you will first have to signup at [hcaptcha.com](https://hcaptcha.com))

However with this setup if you are using custom forms (like the email subscription form bellow) the submission process will be kind of broken. 

So instead what I came up with and I am currently using on 4rkal.com newsletter is to use cloudflare JS Challenge on a specific subdomain.

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