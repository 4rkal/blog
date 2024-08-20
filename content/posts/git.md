---
title: Setup your own git server
date: 2023-03-05T17:11:40+03:00
tags:
  - "selfhosting"
  - "linux"
---
There are numerous benefits to running your own git server as opposed to Github . Your code cannot be used for profit . Additionally, nobody can delete your code base .

# Requirements
1. A computer for your server (running [[linux]] preferably debian)
2. An internet connection (pretty hard without one)
3. A second computer with git installed

# Setup
The first thing you will have to do is install git via your package manager

If you are using apt

`sudo apt install git`

On dnf

`sudo dnf install git`

pacman

`sudo pacman -S git`

After that create a user called git

`sudo useradd git`

You will have to enter some information, you can leave everything except the password blank.

Now login to your git user

`su git`

Now to make our server more secure we are going to use ssh keys.
```
mkdir .ssh
chmod 700 .ssh/
touch .ssh/authorized_keys
chmod 600 .ssh/authorized_keys
```

Now on the computer which you want to commit from you will have to generate a ssh key
On your main machine type.
[My article on keybased auth](../sssh)

`ssh-keygen`

After that you will have to copy your ssh public key to the authorized_keys

`ssh-copy-id user@ip`

(To find out your ip you can type ifconfig)

Now if you try to connect to your server you should be able to login without a password.

`ssh git@ip`

Now you will have to create the folder where all your git repos will be saved.

I will save mine in ~/git , but you can save them wherever you want

`mkdir ~/git`

Now we have to give the ownership of the git folder to the git user

`chown git:git git`

Now for every repository you will have to create a folder.

eg.

`mkdir ~/git/my_cool_project.git`

Now run 

`cd ~/git/my_cool_project.git`

And initiate the git repository

`git init --bare`

Now you can create a couple of files inside of your project (to test it out).

`touch stuff.txt`

Now you can test if your repository is working by cloning the files from another machine running git.

`git clone git@ip:~/git/my_cool_project.git`

You will probably get

`warning: You appear to have cloned an empty repository.`

That is because you haven't committed anything.

```
git add .
git commit -m "first commit"
```

Now if you test that again it should work.

**GG** you did it, you have now successfully set up your own git server

***If you enjoyed this article consider [supporting me](../../donate)

