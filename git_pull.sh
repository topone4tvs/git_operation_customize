#!/usr/bin/env bash
#
current_branch=$(git branch | grep '*' | awk '{print $2}')
git pull origin $current_branch

if [ $? -ne 0 ]
then
    echo "pull error\n"
    exit
else
    echo "=============="
    echo "pull ok"
    echo "=============="
fi
