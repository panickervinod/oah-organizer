#!/bin/sh
# TODO set the below default /init values in the oah-organizer-config.yml
./oah-env-init.sh

# github_namespace is the github user
github_namespace=$1

password=$OAH_GITHUB_REPO_USER_PASS
repolist="../data/oah-ansiblerole-repos"
#repolist="../test/data/githubansiblerolerepos"

for repo_name in $(cat ${repolist} | grep -v '#' );
do
  ./oah-create-githubrepo.sh $repo_name $github_namespace $password
done
