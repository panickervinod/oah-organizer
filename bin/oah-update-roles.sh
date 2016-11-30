
#pass roles folder and github_namespace to commit script



roles_folder=$1
github_namespace=$2


function commit_role_to_github {

  ansible_role_name=$1
  roles_folder=$2
  github_namespace=$3

  if [ -d "$roles_folder" ]; then

    cd $roles_folder/$ansible_role_name
    # readme_updated=$(cat README.md | grep "$ansible_role_name")
    # echo "readme_updated: $readme_updated"

    #if [ "$readme_updated" == "" ]; then
    #  echo "# Openapphack Role : $ansible_role_name" >> README.md
    #else
    #  echo "#### $ansible_role_name updated!" >> README.md
    #fi
  # TODO Command to check if files have changed
    git init
    #git add README.md
    #git add .travis.yml
    git add .
    git commit -m "Auto commit "
    remote_already_added=$(git remote -v | grep "$ansible_role_name" )

    echo "remote_already_added: $remote_already_added "

    if [ "$remote_already_added" == "" ]; then
      git remote add origin git@github.com:$github_namespace/$ansible_role_name.git
    fi

    git push -u origin master


    cd $roles_folder
  fi
}

function github_push {
  git push -u origin master
}

function dry_run_commit_role_to_github {

  ansible_role_name=$1
  roles_folder=$2
  github_namespace=$3

  if [ -d "$roles_folder" ]; then

    cd $roles_folder/$ansible_role_name

     echo "In ---"

     pwd

     git status

     echo "--dry run "
    cd $roles_folder
  fi
}

git config --global user.name "$OAH_USER_FULL_NAME"
git config --global user.email "$OAH_GIT_USER_EMAIL"

for role in $(cat ../data/oah-ansiblerole-repos | grep -v '#' );
do
  if [ -d "$roles_folder" ] && [ "$github_namespace" != "" ]; then
     dry_run_commit_role_to_github $role $roles_folder $github_namespace
     #commit_role_to_github $role $roles_folder $github_namespace
  fi
done
