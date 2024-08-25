#!/bin/bash

# read variable values from conf-file
while read LINE; do
    declare "$LINE";
done < "$(dirname "$0")/dockscripts.conf"
docker_folder=${docker_folder/#\~/${HOME}}
#echo "docker_folder:" $docker_folder
#echo "yaml_folder:" $yaml_folder

# check arguments
if [ $# -eq 0 ]; then
    echo "No arguments given. Possible compose files:"
    files="${docker_folder}/*.yaml"
    for file in $files ; do
        echo "- ${file##*/}"
    done
    exit
fi

# add arguments to array
arguments="$@"

for arg in "$arguments"
do
    arg=${arg%/} #remove trailing /
    if [[ $arg != *".yaml" ]]; then
        arg="${arg}.yaml"
    fi

    file="$(basename $arg)"
    proj="${file%.*}"

    echo "file:" $file
    echo "name:" $proj
    echo "command: rm ${docker_folder}/$file"
    echo "command: wget -nv -P ${docker_folder} ${yaml_folder}/${file}"
	
	rm ${docker_folder}/$file
	wget -nv -P ${docker_folder} $yaml_folder/$file

done