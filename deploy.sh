#!/bin/bash

set -e

echo -e "\033[0;32mDeploying updates to GitHub...\033[0m"

echo $AUTH_SECRET > ~/.git-credentials && chmod 0600 ~/.git-credentials
git config --global credential.helper store
git config --global user.email "dragonsss-blog-bot@users.noreply.github.com"
git config --global user.name "dragonsss-blog-bot"
git config --global push.default simple

rm -rf deployment
git clone -b master https://github.com/DragonSSS/dragonsss.github.io.git deployment
rsync -av --delete --exclude ".git" public/ deployment
cd deployment
git add -A
git commit -m "rebuilding site on `date`, commit ${TRAVIS_COMMIT}
and Travis CI job ${TRAVIS_JOB_NUMBER}" || true
git push

cd ..
rm -rf deployment