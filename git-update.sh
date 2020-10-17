#!/usr/bin/bash

gitdir=$HOME/GitHub/
name=($(ls $gitdir))

for n in ${name[@]}
do
    dir=$gitdir$n
    local=$(git -C $dir rev-list --max-count=1 master)
    global=$(git -C $dir rev-list --max-count=1 origin/master)
    if [ "$local" != "$global" ]; then
        while true; do
            read -p "Do you want to update $n? [y/n]" yn
            case $yn in
                [Yy]* ) echo -e "\e[01;33m ==> UPDATING...\e[0m $n"; git -C $dir pull origin master; echo -e "\e[01;32m ==> UPDATE COMPLETE\e[0m"; break;;
                [Nn]* ) echo "Update available for $n: no changes made"; exit;;
                * ) echo "Please answer yes or no.";;
            esac
        done
        echo "Updated $n"
    else
        echo "No update found for $n"
    fi
done