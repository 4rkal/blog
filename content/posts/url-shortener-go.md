---
title: How to build a URL shortener in Go
description: In this article will be showing you how to build a url shortener in go.
date: 2024-09-22T18:24:11+03:00
draft: false
tags:
  - golang
---
In this article I will be going through how to make a url shortener in go. The final result will look something like this [shortr](https://app.5rkal.com), [source code](https://github.com/4rkal/shortr)

This is a great weekend project especially if you're new to go.

## What is a url shortener?
A URL shortener is a tool that takes a long URL and shrinks it down into something much shorter and easier to share. Instead of copying and pasting a long string of letters, numbers, and symbols, you get a compact version that leads to the same destination. For example, a long URL like `www.somelongwebsite.com/articles/this-is-a-super-long-link` could become something like `bit.ly/abc123`. It's super handy for sharing links on social media, in texts, or anywhere space is limited. And most url shorteners provide analytics like link clicks.


## Requirements
1. Go installed on your system.
2. A code editor, eg [vs code](https://code.visualstudio.com/), [neovim](https://neovim.io/)


In this project I will be using [echo](https://echo.labstack.com/) as the http server and the standard html library.
## Project Setup
Create a new directory to house our project
```shell
mkdir project-name
cd project-name
```

Assuming you have golang installed.

Create a new go module (project):
```shell
go mod init project-name
```

Before we start writing any code we first have to install echo:

```shell
go get github.com/labstack/echo/v4
```

Now create a new file called main.go

```shell
touch main.go
```

And open it in your favorite editor.

## Creating url handlers

```go
func main() {

	e := echo.New()
	
	e.Use(middleware.Logger())
	e.Use(middleware.Recover())
	e.Use(middleware.Secure())
	
	e.GET("/:id", RedirectHandler)
	e.GET("/", IndexHandler)
	e.POST("/submit", SubmitHandler)
	
	e.Logger.Fatal(e.Start(":8080"))

}
```

This will create three different routes/handlers.

The `/:id`, which will redirect the user to the required website

The `/` which will display a url submission form for new urls to be added

Finally the `/submit` which will handle url submissions from the form in `/`

### Redirect Handler

The most important part of our application is the redirect handler, which will redirect the user to the url that was specified. 

Before we create any urls we first have to declare some variables and make a helper function

In order to have a random ending to our url. eg `/M61YlA`, we will create a new function called `GenerateRandomString`

```go
const charset = "abcdefghijklmnopqrstuvwxyzABCDEFGHIJKLMNOPQRSTUVWXYZ0123456789"

func generateRandomString(length int) string {
	seededRand := rand.New(rand.NewSource(time.Now().UnixNano()))
	
	var result []byte
	
	for i := 0; i < length; i++ {
	index := seededRand.Intn(len(charset))
	result = append(result, charset[index])
	}
	
	return string(result)

}
```

This will select `length` random characters from the charset. If you want your slugs (urls), to not contain any capital letters, you can remove them from the charset.


Now we will need to have a place to store all of our links. In this example we will be storing them in memory and not a database.

Create a new struct called `Link` and a map called `LinkMap`:

```go
type Link struct {
	Id string
	Url string
}

var linkMap = map[string]*models.Link{}
```

You can also add some sample data to it.

```go
var linkMap = map[string]*Link{ "example": { Id: "example", Url: "https://example.com", }, }
```


Now we can (finally) create our `RedirectHandler`, which will handle all of the redirects for our url shortener.

```go
func RedirectHandler(c echo.Context) error {
	id := c.Param("id")
	link, found := linkMap[id]
	
	if !found {
	return c.String(http.StatusNotFound, "Link not found")
	}

	return c.Redirect(http.StatusMovedPermanently, link.Url)
}
```

This function will get the id of the link eg `/123` and will look for it in the global `LinkMap`, if it is not available it will return an error that the link was not found. Otherwise it will redirect the user to the specified url using a `301 Permanently Moved` http response code.

## Recap #1

The code so far should look something like this:
```go
package main

import (
"math/rand"
"time"
"github.com/labstack/echo/v4"
"github.com/labstack/echo/v4/middleware"
)

type Link struct {
	Id string
	Url string
}

const charset = "abcdefghijklmnopqrstuvwxyzABCDEFGHIJKLMNOPQRSTUVWXYZ0123456789"

var linkMap = map[string]*Link{ "example": { Id: "example", Url: "https://example.com", }, }

func main() {
	e := echo.New()
	
	e.Use(middleware.Logger())
	e.Use(middleware.Recover())
	e.Use(middleware.Secure())
	
	e.GET("/:id", RedirectHandler)
	//e.GET("/", IndexHandler)
	//e.POST("/submit", SubmitHandler)
	
	e.Logger.Fatal(e.Start(":8080"))
}

func RedirectHandler(c echo.Context) error {
	id := c.Param("id")
	link, found := linkMap[id]
	
	if !found {
	return c.String(http.StatusNotFound, "Link not found")
	}
	
	return c.Redirect(http.StatusMovedPermanently, link.Url)
}

func generateRandomString(length int) string {
	seededRand := rand.New(rand.NewSource(time.Now().UnixNano()))
	
	var result []byte
	
	for i := 0; i < length; i++ {
	index := seededRand.Intn(len(charset))
	result = append(result, charset[index])
	}
	
	return string(result)

}
```

Run the server

```
go run .
```

You might also want to install any missing dependencies:

```shell
go mod tidy
```

If you head to 
`localhost:8080/example` you should be redirected to example.com

### Submission Handlers

We will now define two new routes inside of our main function

```go
e.GET("/", IndexHandler)
e.POST("/submit", SubmitHandler)
```

These two handlers will handle the default page displayed in / which will contain a form that will be submitted to /submit in a post request.


For the `IndexHandler` our code will look something like this:
```go
func IndexHandler(c echo.Context) error {
	html := `
		<h1>Submit a new website</h1>
		<form action="/submit" method="POST">
		<label for="url">Website URL:</label>
		<input type="text" id="url" name="url">
		<input type="submit" value="Submit">
		</form>
		<h2>Existing Links </h2>
		<ul>`
	
	for _, link := range linkMap {
		html += `<li><a href="/` + link.Id + `">` + link.Id + `</a></li>`
	}
	html += `</ul>`
	
	return c.HTML(http.StatusOK, html)
}
```

When we visit `/` a submission for will be rendered, to submit a new website. Under the form we will see all registered links from our `Linkmap`

PS it is not recommended that you use html like this. You should be separating the html file or using a library like [templ](https://templ.guide).

The submission handler `SubmitHandler` should look something like this


```go
func SubmitHandler(c echo.Context) error {
	url := c.FormValue("url")
	if url == "" {
		return c.String(http.StatusBadRequest, "URL is required")
	}
	
	if !(len(url) >= 4 && (url[:4] == "http" || url[:5] == "https")) {
		url = "https://" + url
	}
	
	id := generateRandomString(8)
	
	linkMap[id] = &Link{Id: id, Url: url}
	
	return c.Redirect(http.StatusSeeOther, "/")
}
```

This handler will take a url from the form that was submitted, do some (simple) input validation and then append it to the linkMap.

## Final Recap

The code for our url shortener is:

```go
package main

import (
	"math/rand"
	"net/http"
	"time"
	"github.com/labstack/echo/v4"
	"github.com/labstack/echo/v4/middleware"
)

  

type Link struct {
	Id string
	Url string
}

const charset = "abcdefghijklmnopqrstuvwxyzABCDEFGHIJKLMNOPQRSTUVWXYZ0123456789"

var linkMap = map[string]*Link{"example": {Id: "example", Url: "https://example.com"}}

  
func main() {

	e := echo.New()
	
	e.Use(middleware.Logger())
	e.Use(middleware.Recover())
	e.Use(middleware.Secure())
	
	e.GET("/:id", RedirectHandler)
	e.GET("/", IndexHandler)
	e.POST("/submit", SubmitHandler)
	
	e.Logger.Fatal(e.Start(":8080"))
}

  
func generateRandomString(length int) string {
	seededRand := rand.New(rand.NewSource(time.Now().UnixNano()))

	var result []byte 
	
	for i := 0; i < length; i++ {
		index := seededRand.Intn(len(charset))
		result = append(result, charset[index])
	}

	return string(result)
}

  
func RedirectHandler(c echo.Context) error {
	id := c.Param("id")
	link, found := linkMap[id]

	if !found {
		return c.String(http.StatusNotFound, "Link not found")
	}

	return c.Redirect(http.StatusMovedPermanently, link.Url)
}

  
func IndexHandler(c echo.Context) error {
	html := `
		<h1>Submit a new website</h1>
		<form action="/submit" method="POST">
		<label for="url">Website URL:</label>
		<input type="text" id="url" name="url">
		<input type="submit" value="Submit">
		</form>
		<h2>Existing Links </h2>
		<ul>`
	
	for _, link := range linkMap {
		html += `<li><a href="/` + link.Id + `">` + link.Id + `</a></li>`
	}
	html += `</ul>`
	
	return c.HTML(http.StatusOK, html)
}

  

func SubmitHandler(c echo.Context) error {
	url := c.FormValue("url")
	if url == "" {
		return c.String(http.StatusBadRequest, "URL is required")
	}
	
	if !(len(url) >= 4 && (url[:4] == "http" || url[:5] == "https")) {
		url = "https://" + url
	}
	
	id := generateRandomString(8)
	
	linkMap[id] = &Link{Id: id, Url: url}
	
	return c.Redirect(http.StatusSeeOther, "/")
}
```


## Closing words

This is a great small project if you are new to/learning go.

It can be very helpful if you extend beyond this tutorial. For example here are some other ideas that you can add to the project:
1. Enhance the input validation
2. Track link clicks + Statistics Page
3. Improve UI (html)
4. Dockerizing the application
5. ++

I did all of those and my url shortener (called shortr) can be accessed under the url [app.4rkal.com](https://app.4rkal.com) and the source code is [here](https://github.com/4rkal/shortr)


### Join my mailing list

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