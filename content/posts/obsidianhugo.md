---
title: My Obsidian + Hugo blogging setup (Auto publishing with hotkeys)
description: In this post I go through how I have setup my Obsidian and Hugo blogging workflow. I use a single vault and auto publish my articles with hotkeys.
date: 2024-08-13T17:15:57+03:00
draft: false
---
If you clicked on this article you post probably know what these two technologies are but if you don't here's a quick explanation:

### Obsidian
[Obsidian](https://obsidian.md) is a feature packed markdown editor. But it's not just a markdown editor. It's a way to manage knowledge. It's great for organizing your thoughts in a flexible, non-linear way. 

Obsidian works on all platforms. So you can write articles from basically any platform.

I have been taking all of my notes in it for a couple of months now and it's amazing!

### Hugo
[Hugo](https://gohugo.io) is a ultra fast static website generator made in golang. I have been using hugo for my blog for almost 2 years now. I recently switched the theme of my my blog. Read more about the change [New Look, new start](https://4rkal.eu.org/posts/newlook/). 

# Setup
In this article I will not be showing how to setup these two technologies but merely how to get them to work together. 

If you wan't to learn how I setup this whole blog using hugo read:
[How I setup this blog for free (domain, hosting, ssl) Complete Guide](https://4rkal.eu.org/posts/thisblog?utm_source=internal&utm_campaign=obsidianhugo)

If you wan't a good guide on how to use obsidian read:
[Getting started - obsidian.md](https://help.obsidian.md/Getting+started/Download+and+install+Obsidian)

# Goals
My goals for the setup are:
1. Using a single [obsidian vault](https://help.obsidian.md/Getting+started/Create+a+vault)
2. Have an easy to use [obsidian template](https://help.obsidian.md/Plugins/Templates) that I can use for my blog posts.
3. Keep my personal vault folders private.
4. Have all markdown files in a [public github repository](https://github.com/4rkal/blog/), so that people can propose changes

# Existing setup
The way that my current work flow works is:
1. Edit articles from the content folder.
2. Run hugo command.
3. Push to github.
4. [Render.com](https://render.com) automatically picks up the changes and serves them.


# Journey
*If you want to skip the journey part you can go straight to [The Sauce](#the-sauce)*

I will be going through a couple of mistakes that I made while setting this up.
### Mistake #1
The first idea that I had was to create a simple symlink (I use linux btw) that would link the two folders together. 

Basically I have two folders:
```
blog/
vault/
```

The blog folder contains all the blog folders and the vault is my personal vault. 

The symlink would link these folders
```
blog/content
vault/Blog
```

However **the problem** with a symlink is that the folder content is not visible in my git repo.
This means that people can not propose changes to any of my articles

### Mistake #2

I wanted to have my folders synced. I tried writing a couple of bash scripts that automatically synced the two folders using a cronjob. 
However having that constantly running the background is a waste of resources when I am not running.
Simply running the scripts via cli is just not that smooth.

# The Sauce
Basically the way that I have set this up is I have two folders:
```
blog
vault
```
The blog folder contains all the necessary hugo files and also has a sub directory called content that houses all of the markdown blog files.

I created a new folder inside of my vault called Blog
```
blog/content
vault/Blog
```

After that I copied over all of my files from the content directory to the Blog.

I then started writing this very article

However I needed some way to setup a simple template to contain all of the required hugo front matter. 

That is quite easy.

Read about how to setup templates [Templates - obsidian.md](https://help.obsidian.md/Plugins/Templates)

I created a file called `Blog Post` in my templates folder

My `Blog Post` template contains the following:
```
---
title: "{{Title}}"
description: 
date: "{{date:YYYY-MM-DD}}T{{time:HH:mm:ss}}+00:00"
draft: true
---


**If you enjoyed this article consider [supporting me](https://4rkal.eu.org/donate)**
```

I have all the required front matter including a title, description and a date in the format the hugo asks.

I also added a small donation text that I include at the bottom of every article so that it can be added automatically. 

This means that I can automatically insert this template into any file and start writing!

## Folder Syncing
Now I want all of my files in my vault/Blog directory to be copied over to the blog/content

Thank's to a helpful discord user I found the [obsidian-shellcommands](https://github.com/Taitava/obsidian-shellcommands) plugin. 

**NOTE:** this plugin does not currently work very well with the flatpak version of obsidian (since flatpak isolates the environment) . Using another alternative (.deb or appimage) seems to work.

It allows you to run shell commands in the background with a hotkey.

The steps to set this up are the following:
1. [Install the plugin](https://obsidian.md/plugins?search=shell%20commands)
2. Enable the plugin 
3. Go to the plugin options
4. Click on `New shell command`
5. Now you will need to enter a shell command to copy the files from the one folder to the other. 

On Linux/MacOS that is:

`cp -a ~/folder1/. ~/folder2/` 

in my case that is `cp -a ~/Documents/vault/Blog/. ~/Documents/blog2/content/`

On windows it most probably is:

`robocopy "%USERPROFILE%\folder1" "%USERPROFILE%\folder2" /E /COPYALL`

After that we need to set a hotkey that will run the command

Click on the (+) icon to go to the hotkey settings and assign a hotkey

My hotkey is `CTR + 0`, simply because that was available.

Now every time that I run the hotkey it copies over all of my files to the hugo folder ready to be published

## Auto publishing scripts
I also want to be able to automatically publish my articles. But I also want it to run as a hotkey.

I wrote a small script that does exactly that:
```shell
#!/bin/bash
cd ~/Documents/blog

hugo

git add .
git commit -m "new"
git push -u origin main

```
This script will build my website, commit and push to my github repo, where it is picked up and published. Read [How I setup this blog for free (domain, hosting, ssl) Complete Guide](https://4rkal.eu.org/posts/thisblog?utm_source=internal&utm_campaign=obsidianhugo) to learn how to setup your own blog for free.

Don't forget to make the script executable by running

`chmod +x ./script.sh`

Then create a new shell command (as we did before) and enter the path to your script.

In my case that is:

`~/Documents/blog2/push.sh`

Then enter a hotkey and you're done!
## Conclusion
I can now simply open my obsidian vault, create a new file, insert my template and have all the info automatically entered. 

I then write my article inside of obsidian

Run my hotkey and copy all the files into the hugo directory

Hit another key and my blog is published!

**If you enjoyed this article consider [supporting me](https://4rkal.eu.org/donate)**