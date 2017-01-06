#!/usr/bin/env bash
#
target_branch=$1
need_push_after_update=$2
if [ -z "$need_push_after_update" ]
then
    need_push_after_update=0
fi

if [ -z "$target_branch" ] || [ "$target_branch" != "develop" -a "$target_branch" != "master" ]
then
    target_branch="develop"
fi
current_branch=$(git branch | grep '*' | awk '{print $2}')

git pull origin $current_branch
if [ $? -ne 0 ]
then
    echo "current pull error\n"
    exit
else
    echo "=============="
    echo "current pull ok"
    echo "=============="
fi

git push origin $current_branch
if [ $? -ne 0 ]
then
    echo "current push error\n"
    exit
else
    echo "=============="
    echo "current push ok"
    echo "=============="
fi

git checkout $target_branch

if [ $? -ne 0 ]
then
    echo "check-out error\n"
    exit
else
    echo "=============="
    echo "check-out ok"
    echo "=============="
fi

git pull origin $target_branch

if [ $? -ne 0 ]
then
    echo "pull error\n"
    exit
else
    echo "=============="
    echo "pull ok"
    echo "=============="
fi

git merge $current_branch

if [ $? -ne 0 ]
then
    echo "merge error\n"
    exit
else
    echo "=============="
    echo "merge ok"
    echo "=============="
fi

git checkout $current_branch
echo "=============="
echo "merge finished"
echo "=============="

if [ $need_push_after_update -eq 1 ]
then
    git push origin $target_branch
    if [ $? -ne 0 ]
    then
        echo "=============="
        echo "push error"
        echo "=============="
    else
        echo "=============="
        echo "push ok"
        echo "=============="
    fi
fi
