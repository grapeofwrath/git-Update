#!/usr/bin/bash

gitdir="$HOME/GitHub/"
name=($(ls $gitdir))
aliasn="gitupdate"
aliasf="$HOME/.bash_aliases"
alias="alias $aliasn='bash ~/.scripts/git-Update/git-update.sh'"

if grep -q $aliasn $aliasf; then
     echo "\e[01;32m ==> Starting git-Update...\e[0m";
else
    while true; do
        read -p "Do you want to add gitupdate alias? [y/n]" yn
        case $yn in
            [Yy]* ) if [ -f "$aliasf" ]; then
                    printf "\n# Update GitHub repos\n$alias" >> $aliasf; echo "Alias "$aliasn" added"; break;
                else
                    printf "# Update GitHub repos\n$alias" >> $aliasf; echo "Created $aliasf"; echo "Alias "$aliasn" added to $aliasf";
                fi
                break;;
            [Nn]* ) echo "Alias "$aliasn" not added"; echo "\e[01;32m ==> Starting git-Update...\e[0m"; break;;
            * ) echo "Please answer yes or no.";;
        esac
    done
fi

for n in ${name[@]}
do
    dir=$gitdir$n
    local=$(git -C $dir rev-list --max-count=1 master)
    global=$(git -C $dir rev-list --max-count=1 origin/master)
    git -C $dir remote update;
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