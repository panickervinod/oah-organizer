#!/bin/sh
# TODO set the below default /init values in the oah-organizer-config.yml
./oah-env-init.sh

# usage pass absolute path of parent_folder and old_name and new_name

parent_folder=$1
old_name=$2
new_name=$3
cd $parent_folder
for i in *; do
  new_folder_name="${i/$old_name/$new_name}";
  #echo $new_folder_name
  echo mv $i $new_folder_name;
done
