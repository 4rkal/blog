---
title: Simple Rate Limiting in Go (Gin)
description: In this article will be showing you how to setup rate limiting in the gin library in go.
date: 2025-03-04T19:15:40+03:00
draft: false
---
While working on my [CypherGoat](https://cyphergoat.com) project ,when exposing the API, I needed to setup some rate limiting to avoid getting spammed. Since my API uses Gin as its HTTP library, I used for the `limiter` package to handle the rate limiting.

## Setting up the rate limiting
In my implementation I am setting a 30 request/minute limit on each IP interacting with my API. 

Here is some example code:

```go
package main

import (
	"time"

	"github.com/gin-gonic/gin"
	"github.com/ulule/limiter/v3"
	ginlimiter "github.com/ulule/limiter/v3/drivers/middleware/gin"
	memory "github.com/ulule/limiter/v3/drivers/store/memory"
)

func main() {
	router := gin.Default()

	rate := limiter.Rate{
		Period: 1 * time.Minute,
		Limit:  30, // 30 Requests/minute limit
	}

	store := memory.NewStore()

	// Create the rate limiter
	instance := limiter.New(store, rate)

	// Middleware to apply rate limiting per IP
	router.Use(ginlimiter.NewMiddleware(instance))

	// Example endpoint
	router.GET("/", func(c *gin.Context) {
		c.JSON(200, gin.H{"message": "Hello World!"})
	})

	// Start server
	router.Run(":8080")
}

```

We first create a new gin router called router.

After that we setup a rate limiting policy. In this case it is 30 Requests/minute

After that we create an in memory store to store all of the IP's and their request counts.

Then we create a new rate limiting instance and use it using router.Use

After that we define a standard example route to "/" that returns Hello World and run it on port 8080

You can test this by going to your web browser to `localhost:8080/` and send 30 requests (30 refreshes) in one minute and you should see `Limit exceeded`

That's about it. 


### Join my free newsletter
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
[Deploying Go + Templ + HTMX + TailwindCSS to production](https://4rkal.com/posts/deploy-go-htmx-templ-tailwind-to-production/)

[How to build a URL shortener in Go](https://4rkal.com/posts/url-shortener-go/)

[How to deploy django to production](https://4rkal.com/posts/django-prod/)