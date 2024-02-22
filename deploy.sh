#!/bin/bash

set -e

echo -e "\033[0;32mDeploying updates to GitHub...\033[0m"

git config --global credential.helper store
git config --global user.email "dragonsss-blog-bot@users.noreply.github.com"
git config --global user.name "dragonsss-blog-bot"
git config --global push.default simple

echo "https://${GITHUB_TOKEN}:x-oauth-basic@github.com" > ~/.git-credentials

rm -rf deployment
git clone -b master https://github.com/DragonSSS/dragonsss.github.io.git deployment
rsync -av --delete --exclude ".git" public/ deployment
cd deployment
git add -A
git commit -m "rebuilding site on $(date), commit ${GITHUB_SHA} and GitHub Actions run number ${GITHUB_RUN_NUMBER}" || true
git push

cd ..
rm -rf deployment