---
title: Build a URL shortener in go
description: 
date: 2024-09-14T18:24:11+03:00
draft: false
tags:
  - golang
---
In this article I will be going through how you can create a url shortener in go. The final result will look something like this [shortr](https://app.4rkal.com), [source code](https://github.com/4rkal/shortr)

This is a great weekend project especially if you're new to go.

## Requirements
1. Go installed on your system.
2. A code editor, eg [vs code](https://code.visualstudio.com/), [neovim](https://neovim.io/)


In this project I will be using [echo](https://echo.labstack.com/) as the http server, [templ](https://templ.guide) for the html templates.
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

Before we start writing any code we first have to install a couple packages

Install Templ:
```shell
go install github.com/a-h/templ/cmd/templ@latest
```

Install echo:

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

This will select `lenght` random characters from the charset. If you want your slugs (urls), to not contain any capital letters, you can remove them from the charset.


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
var linkMap = map[string]*Link{ "example.com": { Id: "example.com", Url: "https://example.com", }, }
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
"github.com/labstack/echo/v4"
)

const charset = "abcdefghijklmnopqrstuvwxyzABCDEFGHIJKLMNOPQRSTUVWXYZ0123456789"

var linkMap = map[string]*models.Link{}

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
```



**If you enjoyed this post and want to support my work , you can [donate here](https://4rkal.com/donate).**