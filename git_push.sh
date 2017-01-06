#!/usr/bin/env bash
#
current_branch=$(git branch | grep '*' | awk '{print $2}')
git push origin $current_branch

if [ $? -ne 0 ]
then
    echo "push error\n"
    exit
else
    echo "=============="
    echo "push ok"
    echo "=============="
fi
