#!/bin/sh
# TODO set the below default /init values in the oah-organizer-config.yml
./oah-env-init.sh

# github_namespace is the github user
github_username=$1

password=$OAH_GITHUB_REPO_USER_PASS
repolist="../data/oah-ansiblerole-repos"
#repolist="../test/data/githubansiblerolerepos"

for repo in $(cat ${repolist} | grep -v '#' );
do
  ./oah-create-user-repo.sh $repo $github_username $password
done
