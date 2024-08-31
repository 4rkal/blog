---
title: Selfhosted email newsletter made easy - Listmonk.app
description: 
date: 2024-08-23T11:19:17+03:00
draft: true
---
# What is listmonk?
According to their website [listmonk.app](https://listmonk.app), it's a Self-hosted newsletter and mailing list manager. It is a highly performant single binary application written in go. It offers a super clean dashboard:

![Dashboard](../assets/listmonk.png)

## Why use listmonk (vs buttondown etc)
For me **owning** my newsletter is extremely important. Having your email list locked down on some proprietary platform that can raise it's prices at any time just isn't it. 

However listmonk isn't that simple, you still need an smtp server to send out the emails. 

# Requirements
1. A linux server to host listmonk
2. An email with smtp support. 
# Setup
Installing listmonk is super easy.

First create a directory to host all the configuration files

```bash
mkdir listmonk && cd listmonk
```

Run the automated production install script

```bash
bash -c "$(curl -fsSL https://raw.githubusercontent.com/knadh/listmonk/master/install-prod.sh)"
```

The shell script will:
1. Download the `docker-compose.yml` file and generate a `config.toml`.
2. Run a postgres container.
3. Run the `listmonk` container.

After the script is finished executing you will be able to access the webui at:

`localhost:9000`

You will find the default username and password in the `config.toml` file. 

`cat config.toml` 

It is also recommended that you change the default username and password. 

## Settings

In your listmonk admin portal head to the settings. 

Here you can customize everything from the site name to the favicon, admin emails etc.

![Settings](../assets/listmonk2.png)




**If you enjoyed this article consider [supporting me](https://4rkal.eu.org/donate)**