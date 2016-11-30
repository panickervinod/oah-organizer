#!/bin/sh
# TODO set the below default /init values in the oah-organizer-config.yml
./oah-env-init.sh

#pass roles folder and github_namespace to commit script



roles_folder=$1
github_namespace=$2
file_selector=$3
commit_msg=$4
do_git_push=$5
dry_run=$6


file_selector=${file_selector:="." }
commit_msg=${commit_msg:="Initialized Role Scaffolding"}
do_git_push=${do_git_push:="no"}


function commit_role_to_github {

  local ansible_role_name=$1
  local roles_folder=$2
  local github_namespace=$3
  local file_selector=$4
  local commit_msg=$5
  local do_git_push=$6

  file_selector=${file_selector:="." }
  commit_msg=${commit_msg:="Initialized Role Scaffolding"}
  do_git_push=${do_git_push:="no"}


  if [ -d "$roles_folder/$ansible_role_name" ]; then

    echo "cd $roles_folder/$ansible_role_name"
    cd $roles_folder/$ansible_role_name
  # TODO Command to check if files have changed
    git_already_initialized=$(git status | grep "On branch master" )


    if [ "$git_already_initialized" == "" ]; then
    echo  git init
    fi



    echo git add $file_selector | tr -d '\'

    echo git commit -m "$commit_msg"

    remote_already_added=$(git remote -v | grep "$ansible_role_name" )

    #echo "remote_already_added: $remote_already_added "

    if [ "$remote_already_added" == "" ]; then
      echo git remote add origin git@github.com:$github_namespace/$ansible_role_name.git
    fi

    if [ "$do_git_push" == "yes" ]; then
      echo git push -u origin master
    fi

    echo cd $roles_folder
    cd $roles_folder
  else
    # if [ "$debug" == "yes" ]; then
    #echo  Directory not found!! =>"$roles_folder/$ansible_role_name
    # fi
    echo "cd $roles_folder"
    cd $roles_folder

  fi
}



function github_push {
  git push -u origin master
}

function dry_run_commit_role_to_github {

  local ansible_role_name=$1
  local roles_folder=$2
  local github_namespace=$3
  local file_selector=$4
  local commit_msg=$5
  local do_git_push=$6

  file_selector=${file_selector:="." }
  commit_msg=${commit_msg:="Initialized Role Scaffolding"}
  do_git_push=${do_git_push:="no"}

  if [ -d "$roles_folder/$ansible_role_name" ]; then

    cd $roles_folder/$ansible_role_name

     echo "In ---"

     pwd
     git_already_initialized=$(git status | grep "On branch master" )
     remote_already_added=$(git remote -v | grep "$ansible_role_name" )

      echo git_init_flag=$git_already_initialized
      echo remote_repo_flag=$remote_already_added
      echo git_push_flag=$do_git_push
      echo $ansible_role_name
      echo $github_namespace
      echo git add $file_selector | tr -d '\'

      echo $commit_msg

     git status

     echo "--- Out"
    cd $roles_folder
  else
    "echo Directory not found!! =>"$roles_folder/$ansible_role_name
    cd $roles_folder
  fi
}

git config --global user.name "$OAH_USER_FULL_NAME"
git config --global user.email "$OAH_GIT_USER_EMAIL"


for role in $(cat ../data/oah-ansiblerole-repos | grep -v '#' );
do
  if [ -d "$roles_folder" ] && [ "$github_namespace" != "" ]; then
    if [ "$dry_run" == "yes" ]; then
      dry_run_commit_role_to_github $role $roles_folder $github_namespace $file_selector $commit_msg $do_git_push
     else
      #echo "Not a dry run"
     commit_role_to_github $role $roles_folder $github_namespace  $file_selector $commit_msg $do_git_push
    fi
  fi
done
