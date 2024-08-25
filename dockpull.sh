#!/bin/bash

# read variable values from conf-file
while read LINE; do
    declare "$LINE";
done < "$(dirname "$0")/dockscripts.conf"
docker_folder=${docker_folder/#\~/${HOME}}
#echo "docker_folder:" $docker_folder

# check arguments
if [ $# -eq 0 ]; then
    echo "No arguments given. Possible compose files:"
    files="${docker_folder}/*.yaml"
    for file in $files ; do
        echo "- ${file##*/}"
    done

    read -p "Do you want to pull all compose files? (Y/n) " input
    if [ "$input" == "n" ]; then
        exit
    fi
    arguments=$files

else
    # add arguments to array
    arguments="$@"
fi

for arg in $arguments
do
    arg=${arg%/} #remove trailing /
    if [[ $arg != *".yaml" ]]; then
        arg="${arg}.yaml"
    fi

    file="$(basename $arg)"
    proj="${file%.*}"
    args="-f $file pull"
    
    echo "file:" $file
    echo "name:" $proj
    echo "command: docker compose "$args
	
	docker compose $args
	
done