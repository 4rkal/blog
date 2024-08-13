#!/bin/bash
cd ~/Documents/blog2

hugo

git add .
git commit -m "new"
git push -u origin main
