---
title: Automating your web browser with selenium
date: 2023-02-22T21:23:38+03:00
toc:
  enable: true
  auto: true
featuredImage: selenium.png
featuredImagePreview: ""
tags:
  - automation
  - programming
  - python
---
**Selenium is a very good skill to have as you can automate almost everything that you can do with a web browser.**

In this tutorial, we’ll learn how to use Python and Selenium to automate a web browser. This is an updated version of my previous article which unfortunately doesn't work anymore. If you’re a complete beginner, read my python article to understand the basics. (https://4rkal.com/posts/python/)
## What is selenium?
Selenium is an open source umbrella project for a range of tools and libraries aimed at supporting browser automation. You can use selenium in multiple programming languages including JavaScript (Node.js), C#, Groovy, Java, Perl, PHP, Python, Ruby and Scala and with multiple web browsers including firefox, internet explorer, safary, opera, chrome and edge. Selenium can be very useful for web scraping, automating boring and manual tasks and so much more.
## Setup
To install selenium you first have to install a browser driver. Here is the list of supported web browsers :
- Firefox
- Internet Explorer?
- Safari
- Opera
- Chrome
- Edge
In this article we will be using firefox geckodriver. But you can use any of the browser drivers above.
## Downloading geckodriver
To get started go to github.com/mozilla/geckodriver/releases
Scroll down and select the package for your computer.
I’ll use geckodriver-v0.31.0-linux64.tar.gz because I’m using a linux 64-bit computer.
## Installing geckodriver
The setup varies depending on your operating system.

If you are using Arch Linux:
You can install geckodriver from the aur. Using your favourite aur helper

On linux:
1. Unzip the file
2. Make the file executable
```chmod +x geckodriver```
3. Add the driver to your PATH so other tools can find it:
```export PATH=$PATH:/path-to-extracted-file/```
On windows:
1. Unzip the file
2. Paste the file in the directory that your script will run
## Installing selenium
To install selenium you have to have python and pip installed.Check out my article on python for [more](https://4rkal.com/posts/python)
To install selenium open your cmd or terminal and type:\
```pip install selenium```
That should install it.\
## Basics of selenium
The first thing we have to do is to create a new file with the .py ending eg. main.py\
After you have created it open it in your ide or editor of choice.\

The first thing that we have to do is to import the selenium webdriver :
``` from selenium import webdriver```\
After that we have to specify what webdriver we are using. In our case its firefox
``` browser = webdriver.Firefox()```\
Now we need to specify the url that we want it to go to eg python.org
```
browser.get('https://python.org')
The full code so far is:\
import selenium
from selenium import webdriver
browser = webdriver.Firefox()
browser.get('https://python.org')
```


Now we might want it to click on the Downloads button

There are a few ways to do this
## Method 1 of clicking a button
The first is with XPATH\
To find the xpath of a button / object on a website you have to open your web browser go to the desired website and hit F12 to get the development tools. Now you should click on the select tool (See below)
![Inspect element](../assets/inspect.png)
Click on it and after that hover above the downloads button with your mouse and click it. After that you should see a bit of code getting highlighted. Right click on the bit of code and select Copy then select Xpath
![1](../assets/copy.png)
Now go back to the python file and type:\
```driver.find_element(By.XPATH, 'XPATH_HERE')```\
This will throw an error, to fix that error simply add this at the top of the file\
``` from selenium.webdriver.common.by import By```\
Your code so far should look like this
```
import selenium
from selenium import webdriver
from selenium.webdriver.common.by import By
browser = webdriver.Firefox()
browser.get('https://python.org')
browser.find_element(By.XPATH, '/html/body/div/header/div/nav/ul/li[2]/a').click()
```
## Method 2
XPATH with text
The second method is a bit simpler but not as reliable as the first as there might be many objects with the same name.\
To use this method type:
`browser.find_element(By.XPATH, "//*[contains(text(), 'Downloads')]").click()`
Your code should look something like this
```
import selenium
from selenium import webdriver
from selenium.webdriver.common.by import By
browser = webdriver.Firefox()
browser.get('https://python.org')
browser.find_element(By.XPATH, "//*[contains(text(), 'Downloads')]").click()
```
. . . . .


There many methods on how to locate elements but the above i believe are the easiest.
The methods are the following
- By.ID
- By.NAME
- By.XPATH
- By.LINK-TEXT
- By.TAG_NAME
- By.CLASS_NAME
- By.CSS_SELECTOR\

Read more here: https://selenium-python.readthedocs.io/locating-elements.html 
## Typing text into input fields.
Typing text into input fields is pretty straight forward.\
For that we will use any of the above methods. I'm going to use xpath.\
Find the xpath of any input field, I'm going to use the google.com search field\
Copy the xpath and type:\
```a = browser.find_element(By.XPATH, "XPATH_HERE")```
Paste the xpath in XPATH_HERE

To send keys we need to import the selenium.webdriver.common.keys library for that paste this line of code at the top of your file\
`from selenium.webdriver.common.keys import Keys`\
Now type:\
`a.send_keys("python")`\
After that we want to press the enter key for that type:\
`a.send_keys(Keys.RETURN)`\
The full code should look something like this:
```
import selenium
from selenium import webdriver
from selenium.webdriver.common.by import By
from selenium.webdriver.common.keys import Keys
browser = webdriver.Firefox()
browser.get('https://google.com')
a = browser.find_element(By.XPATH, "/html/body/div[1]/div[3]/form/div[1]/div[1]/div[1]/div/div[2]/input")
a.send_keys("python")
a.send_keys(Keys.RETURN)
````
GG you just automated your first google search!
You might first need to accept cookies for that just follow the steps on how to click a button from above.\
Read more about selenium here: https://selenium-python.readthedocs.io/\

***If you enjoyed this article consider [supporting me](../../donate)**
