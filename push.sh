#!/bin/bash
cd ~/Documents/blog

hugo

git add .
git commit -m "new"
git push -u origin main
