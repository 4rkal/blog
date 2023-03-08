---
title: "Host your own private search engine — searX"
date: 2023-03-03T23:21:53+03:00
tags:
- selfhosting
- privacy
---
We rely on google more and more, but it’s interesting to know how much data Google is now handling. Alphabet aka Google describes its extensive data collection practices in its privacy policy. The company stores an astounding quantity of data. An estimated 15 exabytes of YOUR data are stored by Google. Google is tracking your every move.

# What is searX?
Searx is a free and open-source metasearch engine, available under the GNU Affero General Public License version 3, with the aim of protecting the privacy of its users. In order to do this, Searx does not provide the search engines from which it receives results with users’ IP addresses or search histories. Tracking cookies served by the search engines are blocked, preventing user-profiling-based results modification.

Users can run private instances of Searx on their own computer, but there are also many public, user-run, Searx instances.

In this article i will show you how to run your own searX instance.

# What is a metasearch engine?
A web search engine’s data is used by a metasearch engine, an online information retrieval tool, to create its own results. Metasearch engines automatically query search engines eg Google after receiving user input. The users are shown sufficient data that has been gathered, sorted, and presented.

# Requirements
1. An computer (preferably running linux). Check out my article on how to install linux here https://4rkal.medium.com/install-a-debian-server-54add9133eec
2. an internet connection
# Installing on windows
To install on windows you will have to install wsl and follow the setup guide for linux bellow

To see how to install wsl head to https://docs.microsoft.com/en-us/windows/wsl/install

# Installing on Linux (debian)
First update your system
`sudo apt-get update && sudo apt-get upgrade`
Now install required packages
`sudo apt install -y python3-dev python3-babel python3-venv uwsgi uwsgi-plugin-python3 git build-essential libxslt-dev zlib1g-dev libffi-dev libssl-dev `
Now you will have to create a new user called searx
```
sudo -H useradd --shell /bin/bash --system \
    --home-dir "/usr/local/searx" \
    --comment 'Privacy-respecting metasearch engine' searx

sudo -H mkdir "/usr/local/searx"
sudo -H chown -R "searx:searx" "/usr/local/searx"
```
Now change user to searx

`git clone "https://github.com/searx/searx.git" "/usr/local/searx/searx-src"t`

Now create a virtual environment

`echo ". /usr/local/searx/searx-pyenv/bin/activate" >>  "/usr/local/searx/.profile"`

To install searx’s dependencies, exit the searx bash session you opened above and restart a new. Before install, first check if your virtualenv was sourced from the login (~/.profile):

Update dependencies

```
pip install -U pip
pip install -U setuptools
pip install -U wheel
pip install -U pyyaml
```
Jump to searx’s working tree and install searx into virtualenv

```
cd "/usr/local/searx/searx-src"
pip install -e .
```
Now go back to your default user

`exit`

And type
`sudo -H mkdir -p "/etc/searx"`

Then

```
sudo -H cp "/usr/local/searx/searx-src/utils/templates/etc/searx/use_default_settings.yml" \
             "/etc/searx/settings.yml"
```

Now you can edit your settings file

`sudo nano /etc/searx/settings.yml`

You can change the secret_key

I will change the port and bind_address but you can change whatever you want.

Now log back in to your searx user

`sudo -H -u searx -i`

Change directory

`cd /usr/local/searx/searx-src`

Export the settings path

```
export 
SEARX_SETTINGS_PATH="/etc/searx/settings.yml"
```
Finally run the web app
`python searx/webapp.py`
Now if you head to 127.0.0.1:8888 you should be able to see something like this
{{< image src="../assets/searx.webp" caption="">}}
**GG** you did it enjoy privacy (in search engines)

