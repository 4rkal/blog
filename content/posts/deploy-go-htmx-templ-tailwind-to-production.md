---
title: Deploying Go + Templ + HTMX + TailwindCSS to production
description: In this article I will be showing you how to deploy the GoTTH stack (Go Templ htmx tailwind) to production.
date: 2025-03-06T14:16:29+03:00
draft: false
tags:
  - programming
  - golang
  - cyphergoat
  - linux
---
I recently created my very own cryptocurrency exchange aggregator called [cyphergoat](https://cyphergoat.com) it finds you the best rate to swap your crypto from different partnered exchanges. 

It has two parts:
1. An API that interacts with exchanges. Written in go and uses gin
2. The Web UI that is written in go and uses a combination of HTML, HTMX, tailwindcss, CSS and Javascript in templ templates. Aka the GoTTH stack. It interacts with the api in order to find rates etc. 

What is extremely cool with this stack and setup is that we are able to produce **a single binary** with everything included for each part and ship it to the server. On the webui side this is possible since the html is compiled into go code using templ and then shipped with the binary.

In this article I will be going through my setup to make it easier for you to make something like this.

## Setup
I am using a debian 12 server which will expose my application via cloudflare tunnels. All of the static files are being served via nginx and the api and website binaries are ran as systemd services.

In this guide I will show you how I set this up.

## The setup
I have a single folder on my dev machine called cyphergoat:
It contains
```
api/
web/
builds/
```

The api folder houses the api source code.
The web the website source code.

And the builds houses all of the builds that are deployed to the server.
### Tailwind
The first real challenge comes with setting up tailwindcss correctly.

In my web project I have a static folder specifically for static files. Inside of it I have two files
```
/web
	styles.css
	tailwind.css
```

The `styles.css` simply contains:
```
@import "tailwindcss";
```

The tailwind.css file is where tailwind-cli will save it's stuff.

To build the tailwind stuff I simply run

```
npx @tailwindcss/cli -i ./static/styles.css -o ./static/tailwind.css --watch
```

(assuming you have tailwind-cli installed)

In my header.templ file (the header of all the pages) at the top I have
```
<link href="/static/tailwind.css" rel="stylesheet">

<link href="/static/styles.css" rel="stylesheet">
```

And the files are being served using echo's e.Static (in my main.go file )

```go
func main(){
e := echo.New()

e.Use(middleware.Logger())
e.Use(middleware.Recover())
e.Use(middleware.Secure())


e.Static("/static", "static") // Serves content from static folder.

// Rest of the handlers
}

```

## Server

On my server side I have a debian 12 vm running on proxmox.

In my users home directory I have a folder with the following contents:
```
cyphergoat/
├── api
├── static/
└── web
```

The static folder contains all of the static files (including tailwind.css and styles.css) and the **web** and **api** are the binaries. 

I then have two systemd services for these exectuables:

The` cg-api.service`
`/etc/systemd/system/cg-api.service`

```systemd
[Unit]
Description=CypherGoat API
After=network.target

[Service]
User=arkal
Group=www-data
WorkingDirectory=/home/arkal/cyphergoat
ExecStart=/home/arkal/cyphergoat/api
Restart=always
RestartSec=1

[Install]
WantedBy=multi-user.target

```

And `cg-web.service`
`/etc/systemd/system/cg-web.service`

```systemd
[Unit]
Description=CypherGoat Web
After=network.target

[Service]
User=arkal
Group=www-data
WorkingDirectory=/home/arkal/cyphergoat
ExecStart=/home/arkal/cyphergoat/web


[Install]
WantedBy=multi-user.target

```

Both are owned by the group `www-data` (this is probably not necessary for the api), in order to make it easier to serve them via nginx. 

### Nginx

The website is communicating with the api but I still need to make the web-ui accessible. 

I have setup an nginx site with the following configuration:
`/etc/nginx/sites-available/cg`
```nginx
server {
    server_name cyphergoat.com;

    location / {
        proxy_pass http://127.0.0.1:4200;
        proxy_set_header Host $host;
        proxy_set_header X-Real-IP $remote_addr;
        proxy_set_header X-Forwarded-For $proxy_add_x_forwarded_for;
        proxy_set_header X-Forwarded-Proto $scheme;
    }

    location /static/ {
        alias /var/www/static/;
        expires 30d;
    }
    
    # Optional robots.txt
    location = /robots.txt {
        root /var/www/static;
        access_log off;
        log_not_found off;
    }

    listen 80;
}

```

I have also setup certbot to have an ssl cert.

You can setup certbot by running:

```
sudo apt install certbot python3-certbot-nginx -y
```

Generate the ssl cert:
```
sudo certbot --nginx -d cyphergoat.com
```

Read [Self host your own website](https://4rkal.com/posts/shwebsite/) for a more in depth nginx setup.

### Cloudflare Tunnels
I am currently making my website accessible using cloudflare pages. It is an extremely easy to use port forwarding solution 

To do this you will need a cloudflare account and a domain pointed to cloudflare.

First head to the [Zero Trust Dashboard](https://one.dash.cloudflare.com/)

Under `Networks` click on `Tunnels` and then `Create a tunnel`

Once created you should `Install and run a connector`, follow the instructions on the page for your specific setup. 

After the connector is running you should click on the `Public Hostname` tab and `Add a public hostname`.

Now you should see something like this: 
![Cloudflare dashboard](../assets/gitea2.png)

Fill in the info as I have. 
The service type should be `HTTP` and the url should be `127.0.0.1:80` or `localhost:80`

Obviously there is no reason to make your api publicly accessible when deploying your website.


## Deployment

In order to deploy my binaries I went ahead and created a quick bash script:

```bash
cd api
go build -o ../builds/ .

cd ../web

templ generate && go build -o ../builds/web cmd/main.go

cd ..
rsync -urvP ./builds/ user@SERVER:/home/user/cyphergoat
rsync -urvP ./web/static user@SERVER:/home/user/cyphergoat/
rsync -urvP ./api/coins.json user@SERVER:/user/user/cyphergoat/

```

The script will build the api, generate the templ files and build the webui and then sends everything over to my server (including the static folder)

I then ssh into my server 

`ssh user@ip`

and then restart the services

`sudo systemctl restart cg-api cg-web`

And that's it.


## Join my free newsletter!
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


### Related Articles
[Simple Rate Limiting in Go (Gin)](https://4rkal.com/posts/go-rate-limit)

[How to build a URL shortener in Go](https://4rkal.com/posts/url-shortener-go/)

[How to deploy django to production](https://4rkal.com/posts/django-prod/)
