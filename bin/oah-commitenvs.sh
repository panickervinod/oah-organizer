#!/bin/sh
# TODO set the below default /init values in the oah-organizer-config.yml
./oah-env-init.sh

#pass envs folder and github_namespace to commit script

#envs_folder="../envs"
#github_namespace=panickervinod

envs_folder=$1
github_namespace=$2
file_selector=$3
commit_msg=$4
do_git_push=$5
dry_run=$6


file_selector=${file_selector:="." }
commit_msg=${commit_msg:="Initialized Envs Scaffolding"}
do_git_push=${do_git_push:="no"}


function commit_env_to_github {

  local oah_env_name=$1
  local envs_folder=$2
  local github_namespace=$3
  local file_selector=$4
  local commit_msg=$5
  local do_git_push=$6

  file_selector=${file_selector:="." }
  commit_msg=${commit_msg:="Initialized Role Scaffolding"}
  do_git_push=${do_git_push:="no"}


  if [ -d "$envs_folder/$oah_env_name" ]; then

    echo "cd $envs_folder/$oah_env_name"
    cd $envs_folder/$oah_env_name
  # TODO Command to check if files have changed
    git_already_initialized=$(git status | grep "On branch master" )


    if [ "$git_already_initialized" == "" ]; then
    echo  git init
    fi



    echo git add $file_selector | tr -d '\'

    echo git commit -m "$commit_msg"

    remote_already_added=$(git remote -v | grep "$oah_env_name" )

    #echo "remote_already_added: $remote_already_added "

    if [ "$remote_already_added" == "" ]; then
      echo git remote add origin git@github.com:$github_namespace/$oah_env_name.git
    fi

    if [ "$do_git_push" == "yes" ]; then
      echo git push -u origin master
    fi

    echo cd $envs_folder
    cd $envs_folder
  else
    # if [ "$debug" == "yes" ]; then
    #echo  Directory not found!! =>"$envs_folder/$oah_env_name
    # fi
    echo "cd $envs_folder"
    cd $envs_folder

  fi
}



function github_push {
  git push -u origin master
}

function dry_run_commit_env_to_github {

  local oah_env_name=$1
  local envs_folder=$2
  local github_namespace=$3
  local file_selector=$4
  local commit_msg=$5
  local do_git_push=$6

  file_selector=${file_selector:="." }
  commit_msg=${commit_msg:="Initialized Role Scaffolding"}
  do_git_push=${do_git_push:="no"}

  if [ -d "$envs_folder/$oah_env_name" ]; then

    cd $envs_folder/$oah_env_name

     echo "In ---"

     pwd
     git_already_initialized=$(git status | grep "On branch master" )
     remote_already_added=$(git remote -v | grep "$oah_env_name" )

      echo git_init_flag=$git_already_initialized
      echo remote_repo_flag=$remote_already_added
      echo git_push_flag=$do_git_push
      echo $oah_env_name
      echo $github_namespace
      echo git add $file_selector | tr -d '\'

      echo $commit_msg

     git status

     echo "--- Out"
    cd $envs_folder
  else
    "echo Directory not found!! =>"$envs_folder/$oah_env_name
    cd $envs_folder
  fi
}

git config --global user.name "$OAH_USER_FULL_NAME"
git config --global user.email "$OAH_GIT_USER_EMAIL"


for role in $(cat ../data/oah-envs-repos | grep -v '#' );
do
  if [ -d "$envs_folder" ] && [ "$github_namespace" != "" ]; then
    if [ "$dry_run" == "yes" ]; then
      dry_run_commit_env_to_github $role $envs_folder $github_namespace $file_selector $commit_msg $do_git_push
     else
      #echo "Not a dry run"
     commit_env_to_github $role $envs_folder $github_namespace  $file_selector $commit_msg $do_git_push
    fi
  fi
done
