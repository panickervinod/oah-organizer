#!/bin/sh
# TODO set the below default /init values in the oah-organizer-config.yml
./oah-env-init.sh

# TODO set the below default /init values in the oah-organizer-config.yml
roles_folder="$OAH_ORGANIZER_ROOT/roles"
github_namespace="$OAH_GITHUB_NAMESPACE"
#file_selector="\*.\*"
file_selector="."
commit_msg="dryrun"
do_git_push="yes"
dry_run="no"
tmp_script_file="../tmp/oahscript.sh"
# echo $file_selector
# echo $dry_run

./oah-commitroles.sh $roles_folder $github_namespace $file_selector $commit_msg $do_git_push $dry_run > $tmp_script_file

if [ "$dry_run" == "no" ]; then
chmod +x $tmp_script_file
./$tmp_script_file
fi
