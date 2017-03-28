#!/bin/bash

SYNC_DIR="sync-stage"
MAIN_REPO_URL="git@github.ibm.com:DX/prod-infra-mesos-kafka.git"
REPLICA_REPO="git@github.com:eli-jordan/kafka.git"

rm -rf "$SYNC_DIR"

echo "Fetching main repo from $MAIN_REPO_URL"
git clone --bare "$MAIN_REPO_URL" "$SYNC_DIR"
cd "$SYNC_DIR"
git remote add --mirror=fetch replica "$REPLICA_REPO"
git fetch origin --tags

echo "Pushing to replica repo $REPLICA_REPO"
git push replica --all 
git push replica --tags

rm -rf "$SYNC_DIR"