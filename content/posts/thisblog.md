---
title: How I setup this blog for free (domain, hosting, ssl) Complete Guide
date: 2023-03-23T18:13:03+03:00
tags:
---
In this article I’ll show you how I setup this blog completely for free. I’ll show you how to use hugo to write your blog, Cloudflare and eu.org for your domain and ssl, Render and github for the hosting and even how to get your blog on google.
# What is hugo?
Hugo is a fast and popular open-source static site generator used for creating static websites without requiring a database or dynamic components.
# Hugo setup
Download and install hugo

On debian type

`sudo apt install hugo`

On arch type

`sudo pacman -S hugo`

On fedora type

`sudo dnf install hugo`
On windows:

Navigate to https://github.com/gohugoio/hugo/releases/latest

Find the windows version and download it.

Unzip the file to your desired directory

Add this directory to the PATH environment variable


Read more: https://gohugo.io/installation/windows/

# Creating the hugo site
Open up a terminal and type:

`hugo new site my_website`

And then cd into that directory

`cd my_website`

After that we will have to install a theme. I will be using the LoveIt theme but you can use any other theme

All hugo themes
https://themes.gohugo.io/

**NOTE: I now use a completely different theme [New look, new start](https://4rkal.com/posts/newlook/)** 

For the LoveIt theme:

The first thing we will have to do is type

`git clone https://github.com/dillonzq/LoveIt.git themes/LoveIt`

You will have to have git installed if you don’t, follow the instructions on the page to download it.

Now we will have to create some basic configuration. Every theme has its own so you should first check your themes documentation. Some basic settings work for all themes.

Here is an example of the most basic settings for the LoveIt theme. (it has to be saved in config.toml)

```
baseURL = "http://example.org/"

# Change the default theme to be use when building the site with Hugo
theme = "LoveIt"

# website title
title = "My New Hugo Site"

# language code ["en", "zh-CN", "fr", "pl", ...]
languageCode = "en"
# language name ["English", "简体中文", "Français", "Polski", ...]
languageName = "English"

# Author config
[author]
  name = "xxxx"
  email = ""
  link = ""

# Menu config
[menu]
  [[menu.main]]
    weight = 1
    identifier = "posts"
    # you can add extra information before the name (HTML format is supported), such as icons
    pre = ""
    # you can add extra information after the name (HTML format is supported), such as icons
    post = ""
    name = "Posts"
    url = "/posts/"
    # title will be shown when you hover on this menu link
    title = ""
  [[menu.main]]
    weight = 2
    identifier = "tags"
    pre = ""
    post = ""
    name = "Tags"
    url = "/tags/"
    title = ""
  [[menu.main]]
    weight = 3
    identifier = "categories"
    pre = ""
    post = ""
    name = "Categories"
    url = "/categories/"
    title = ""

# Markup related configuration in Hugo
[markup]
  # Syntax Highlighting (https://gohugo.io/content-management/syntax-highlighting)
  [markup.highlight]
    # false is a necessary configuration (https://github.com/dillonzq/LoveIt/issues/158)
    noClasses = false
```

You can find my configuration [here](https://github.com/4rkal/blog/blob/main/config.toml)

You can view your page live by running

`hugo serve`

Let’s move on to the next step.

# Adding articles to our blog
The first thing we will have to do is create a new file with any name ending in .md inside of our content folder. I like to separate my posts from other sections so I will create another folder inside of the content one called posts.

You can run this command to add the file

`hugo new posts/first_post.md`

Now open the file that was just created using your favorite text editor.

You should see something like this:

```
---
title: "Epic title"
date: 2023-03-23T18:13:03+03:00
draft: true
---
```

If you want the post to be publicly visible on your blog delete the draft line. or set it to false.

Now if we want to add some content we will have to write it in markdown. Heres a great guide on some basic markdown syntax https://hugoloveit.com/basic-markdown-syntax/

Heres an example of some content

```
---
title: "My First Post"
date: 2023-03-23T18:13:03+03:00
draft: false
---

# Welcome to my blog!

This is my first post. Here's a picture of my cat:

![My cat](/images/cat.jpg)
```

Using the above steps you can add all of your articles to the blog.

Now that we are done with that let me show you how we will publish our blog.

# Domain
More like a sub-domain. Head to eu.org and get a free domain. Create an account and submit a request for a new domain. It might take some time even months to get accepted.

I have already registered 4rkal.eu.org from there.

Now we will have to get some ssl certificates using cloudflare.

SSL certificates just make your site use https instead of http this is really great for seo and doesn’t make your site look sus.

Head over to cloudflare.com and create an account for free.

After you are done with that go to your dashboard and select websites and then add a site.

You should see something like this

![](../assets/cloudflare.webp)

Enter your websites url and click on add site.

After that select the free plan and continue.

Now it will review your dns records. Just select continue and confirm

Now you will have to change your domain’s name servers.

To do that head back to eu.org select your domain and click on the nameservers tab and select server names.

Now in the input fields enter the name servers.

The name servers will most probably be:

```
nancy.ns.cloudflare.com
uriah.ns.cloudflare.com
```

Here’s how it should probably look:

![](../assets/euorg.webp)

Now click on the submit button.

You should probably get

```
No error, applying changes...

Done
```

If you get an error you probably screwed up one of the above steps. Just try again.

After your name servers have been changed and everything is done, in your domain dashboard select SSL/TLS. Just select full encryption.

# Hosting our site.
First create a github account. Head to github.com for that. You will also have to install [git](https://git-scm.com/)

After you have done that navigate to your blog’s root directory and type:
```
git init
hugo
git add .
git commit -m "first commmit"
git branch -M main
```

Now go to github and create a new repository.

You should now type:

`git remote add origin YOURURL`

instead of YOURURL enter the url to your github repo and add a .git ending

eg

`git remote add origin https://github.com/4rkal/blog.git`

Now push the changes with

`git push -u origin main`

After that if you refresh the page of your github repo you should see everything there.

Now head to [render.com](https://render.com) and create an account

On your dashboard select +New and then static site.

Now you will be prompted to connect a github repository. Just connect your account and add that repository.

eg

![](../assets/render.webp)

Now enter a service name eg myblog and in the publish directory just add

`public`

Then click on create static site.

After it has been deployed successfully head over to the settings and in the custom domains tab click on add custom domain.

In the field enter the domain that we registered with eu.org previously.

Now go to cloudflare and in your domain dashboard select dns and click on add a new record.

In the type dropdown select CNAME in the name field add @ and in the target add your blog’s url from render. Mine is https://blog-ygtj.onrender.com/. Also untick the proxy status.

Now we will have to do the same but with the www.

Just do the same steps as above but instead of @ just add `www`

That’s it. After a couple of minutes your blog should be live.

# SEO Google and bing
If you want to get your website on google and bing it’s pretty easy

If you want to get your website on google follow the guide listed here
https://developers.google.com/search

For bing it should be pretty much the same process on https://www.bing.com/webmasters/

***If you enjoyed this article consider [supporting me](../../donate)**




