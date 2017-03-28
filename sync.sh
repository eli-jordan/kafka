#!/bin/bash

#
# Syncs the branches and tags in this repo with the mirror on public github
#

SYNC_DIR="sync-stage"

# The internal form we have of the open source project
INTERNAL_FORK_REPO="git@github.ibm.com:DX/prod-infra-mesos-kafka.git"

# The public replica of our internal repo, that is used to submit pull requests
REPLICA_OF_INTERNAL_FORK="git@github.com:eli-jordan/kafka.git"

ROOT="$PWD"

perform_sync() {
    rm -rf "$SYNC_DIR"

    echo "Fetching main repo from $INTERNAL_FORK_REPO"
    git clone --bare "$INTERNAL_FORK_REPO" "$SYNC_DIR"
    cd "$SYNC_DIR"
    git remote add --mirror=fetch replica "$REPLICA_OF_INTERNAL_FORK"
    git fetch origin --tags

    echo "Pushing to replica repo $REPLICA_OF_INTERNAL_FORK"
    git push replica --all
    git push replica --tags

    cd "$ROOT"
    rm -rf "$SYNC_DIR"
}

perform_sync

