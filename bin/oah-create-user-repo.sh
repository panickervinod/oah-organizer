#!/bin/sh
# TODO set the below default /init values in the oah-organizer-config.yml
./oah-env-init.sh

# Create repo
repo=$1
github_username=$2
password=$3

node ../lib/oah-create-user-repo.js $repo $github_username $password
