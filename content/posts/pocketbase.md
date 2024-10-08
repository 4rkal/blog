---
title: PocketBase self-hosted Firebase alternative
date: 2023-03-06T20:44:46+03:00
tags:
  - selfhosting
  - privacy
---
# What is PocketBase
PocketBase is an open source backend made in go consisting of embedded database (SQLite) with realtime subscriptions, built-in auth management, convenient dashboard UI and simple REST-ish API.

## Install PocketBase
The first thing that you will have to do is head to https://pocketbase.io and select the file for your operating system. Since I am using linux I will show how to set this up on linux but it should be pretty similar for any other os.

Unzip the file and open up a terminal to the path that you extracted the file to and type:

`./pocketbase serve`

If you want to serve some static content you can create a new directory called pb_public

`mkdir pb_public`

Then paste any content into that directory

eg.

```
<!DOCTYPE html>
<html lang="en">
<head>
    <meta charset="UTF-8">
    <meta http-equiv="X-UA-Compatible" content="IE=edge">
    <meta name="viewport" content="width=device-width, initial-scale=1.0">
    <title>Epic Website</title>
</head>
<body>
    <h1>My epic website</h1>
</body>
</html>
```

And save that as index.html inside of the pb_public folder

Now if you head to http://127.0.0.1:8090/ you should see the website that we entered above.

If you go to http://127.0.0.1:8090/_/ it will take you to an admin portal. There you should create a account. After you have setted up your account you should see something like this.

![1](../assets/pocketbase.webp)

Here you can add and create users


![2](../assets/pocketbase2.webp)

And also create custom collections eg

![2](../assets/pocketbase3.webp)

If you click on the settings icon you can see that you will be able to add applications, mail settings, file storage (s3) , export/import collections, add or remove auth providers, token options and add/remove admins.

That’s it for now if you want to learn more check out https://pocketbase.io/docs/

***If you enjoyed this article consider [supporting me](../../donate)***



