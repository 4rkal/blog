---
title: "How to Set Up Your Own Git Server: A Simple Guide"
date: 2023-03-05T17:11:40+03:00
tags:
  - selfhosting
  - linux
---
Thinking about setting up your own Git server? There are plenty of perks to doing so instead of relying on platforms like GitHub. For starters, you'll have complete control over your code, ensuring it can’t be used for profit or deleted by anyone but you.

### What You’ll Need
1. **A Computer for Your Server**: Ideally running Linux (Debian is a solid choice).
2. **Internet Connection**: Pretty essential for accessing your server remotely.
3. **Another Computer with Git Installed**: This is what you'll use to interact with your server.

### Step-by-Step Setup Guide

#### 1. Install Git on Your Server
First, you need to install Git on your server. Depending on your Linux distribution, use one of these commands:

- For Debian-based systems (like Ubuntu):
  ```bash
  sudo apt install git
  ```
- For Fedora-based systems:
  ```bash
  sudo dnf install git
  ```
- For Arch-based systems:
  ```bash
  sudo pacman -S git
  ```

#### 2. Create a Git User
Next, create a dedicated user for Git operations:

```bash
sudo useradd git
```

You'll be prompted to enter some information. Feel free to leave everything blank except for the password.

#### 3. Secure Your Server with SSH Keys
Log in as the new Git user:

```bash
su git
```

Then, enhance security by setting up SSH keys:

```bash
mkdir .ssh
chmod 700 .ssh/
touch .ssh/authorized_keys
chmod 600 .ssh/authorized_keys
```

#### 4. Generate and Add SSH Keys
On your main machine (the one you’ll be committing from), generate an SSH key:

```bash
ssh-keygen
```

Copy the SSH public key to your server:

```bash
ssh-copy-id git@your-server-ip
```

To find your server's IP, use:

```bash
ifconfig
```

Now, you should be able to log in to your server without needing a password:

```bash
ssh git@your-server-ip
```

#### 5. Set Up Your Git Repository Directory
Create a directory to store your Git repositories. For example:

```bash
mkdir ~/git
```

Give ownership of this directory to the Git user:

```bash
chown git:git ~/git
```

#### 6. Create a New Repository
For each project, create a separate directory:

```bash
mkdir ~/git/my_cool_project.git
```

Initialize the repository as a bare repository (suitable for sharing):

```bash
cd ~/git/my_cool_project.git
git init --bare
```

#### 7. Test Your Setup
To test your new Git server, try cloning the repository from another machine:

```bash
git clone git@your-server-ip:~/git/my_cool_project.git
```

You might see:

```bash
warning: You appear to have cloned an empty repository.
```

That’s because you haven’t added any files yet. Go ahead and add a file:

```bash
touch stuff.txt
```

Commit your changes:

```bash
git add .
git commit -m "first commit"
```

Now, try cloning again, and everything should work smoothly.

### Congratulations!
You’ve successfully set up your own Git server! Now you have full control over your code and can collaborate without relying on third-party services.

*Enjoyed this guide? Consider [supporting me](https://4rkal.com/donate) to help me create more content like this!*