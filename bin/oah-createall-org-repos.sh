#!/bin/sh
# TODO set the below default /init values in the oah-organizer-config.yml
./oah-env-init.sh

github_username=$1
github_org=$2

password=$OAH_GITHUB_REPO_USER_PASS
repolist="../data/oah-ansiblerole-repos"
#repolist="../test/data/githubansiblerolerepos"

for repo_name in $(cat ${repolist} | grep -v '#' );
do
  ./oah-create-org-repo.sh $repo_name $github_username $password $github_org
done
