---
title: "Securing ssh with Key-Based authentication"
date: 2023-02-25T21:08:47+03:00
tags:
- selfhosting
- ssh
---
SSH keys provide an extremely secure way of logging into your server.

# SSH Password Based VS Key Based Authentication

Clients can be authenticated by an SSH server in a variety of ways. The most basic is password authentication, which is simple to use but not particularly secure. The more advanced and secure way is via ssh keys.Brute-forcing a password-protected account is quite possible thanks to modern computing power and automated scripts. The solution to that is ssh key based authentication.

# How does Key Based Authentication work?
SSH key pairs are two cryptographically secure keys that allow a client to connect to an SSH server. A public key and a private key make up each key pair.The client keeps the private key, which should be kept completely confidential.

If the attacker has access to the private key, they will be able to enter into servers using the corresponding public key without requiring further authentication. A passphrase can be used to encrypt the key on disc as an extra precaution.

The related public key can be freely shared without causing any harm. The public key can be used to encrypt communications that can only be decrypted with the private key. This attribute is used to verify the authenticity of the key pair. The public key is placed on a distant server that you wish to use SSH to access. The key is saved in a special file called /.ssh/authorized keys in the user account you’ll be login into.

When a client uses SSH keys to authenticate, the server can check if the client has the private key. A shell session is started or the requested command is executed if the client can verify ownership of the private key.

# Setting up
The first thing we will have to to do is generate an SSH key pair on your local computer.

To do that type

`ssh-keygen`

You should see something like this
```
Generating public/private rsa key pair.
Enter file in which to save the key (/home/4rkal/.ssh/id_rsa): 
Enter passphrase (empty for no passphrase):
```
If you want to you can enter a passphrase to encrypt the private key.

After that your key should be generated.

Now you will have to copy your public key to your server.

To do that type

`ssh-copy-id username@host_ip`

(find your servers ip by typing ifconfig in your server)

eg. 

`ssh-copy-id server@192.168.1.13'

Try to ssh into your server by typing

`ssh username@host_ip`

You should be able to login into your server without the password. However, brute force attacks continue to threaten your server. Now we have to disable password based authentication.

First login to your ssh server by typing
`ssh username@host_ip`

Now we have edit the ssh config

sudo nano /etc/ssh/sshd_config

You should see a large file that starts with

```
#       $OpenBSD: sshd_config,v 1.103 2018/04/09 20:41:22 tj Exp $
```

At this point press cntrl w and search for `PasswordAuthentication`

Uncomment the line that says

`#PasswordAuthentication yes`

And change it to

`PasswordAuthentication no`

Now press cntrl s to save and cntrl x to exit

After that restart the ssh service with

`sudo service ssh restart`

Now try to ssh into your server from another machine or a vm and you should see something like this

`server@192.168.1.13: Permission denied (publickey)`

GG you have now secured your server
