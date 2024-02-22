#!/bin/bash

set -e

echo -e "\033[0;32mDeploying updates to GitHub...\033[0m"

echo "Token length: ${#GH_TOKEN}"

git config --global user.email "dragonsss-blog-bot@users.noreply.github.com"
git config --global user.name "dragonsss-blog-bot"

rm -rf deployment
git clone -b master https://${GH_TOKEN}@github.com/DragonSSS/dragonsss.github.io.git deployment
rsync -av --delete --exclude ".git" public/ deployment
cd deployment
git add -A
git commit -m "rebuilding site on $(date), commit ${GITHUB_SHA} and GitHub Actions run number ${GITHUB_RUN_NUMBER}" || true
git remote set-url master https://${GH_TOKEN}@github.com/DragonSSS/dragonsss.github.io.git
git push

cd ..
rm -rf deployment