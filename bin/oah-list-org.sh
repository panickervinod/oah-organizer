#!/bin/sh
# TODO set the below default /init values in the oah-organizer-config.yml
./oah-env-init.sh

# Create repo
repo=$1
github_username=$2
password=$3
github_org=$4

node ../lib/oah-github.js $repo $github_username $password $github_org
