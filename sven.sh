#!/bin/sh

if [ -z "${GITHUB_TOKEN}" ]; then
    echo "Error: Not found - GITHUB_TOKEN"
    exit 1
fi

if [ -z "${BRANCH_NAME}" ]; then
   export BRANCH_NAME=master
fi

remote_repo="https://${GITHUB_ACTOR}:${GITHUB_TOKEN}@github.com/${GITHUB_REPOSITORY}.git"
git config http.sslVerify false
git config user.name "Snowkelus"
git config user.email "actions@users.noreply.github.com"
git remote add publisher "${remote_repo}"
git show-ref # useful for debugging
git branch --verbose

git lfs install

git checkout ${BRANCH_NAME}
git add -A
timestamp=$(date -u)
git commit -m "Deploying Repository Code: ${timestamp} ${GITHUB_SHA}" || exit 0
git pull --rebase publisher ${BRANCH_NAME}
git push publisher ${BRANCH_NAME}
