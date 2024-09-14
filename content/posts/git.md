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