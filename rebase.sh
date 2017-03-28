#!/bin/bash

CURRENT_BRANCH="$(git rev-parse --abbrev-ref HEAD)"

git remote add upstream git@github.com:mesos/kafka.git

git fetch upstream && \
git checkout master && \
git pull upstream master && \
git push origin master

git checkout "$CURRENT_BRANCH"
git branch