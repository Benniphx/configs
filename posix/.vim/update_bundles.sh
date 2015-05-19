#!/usr/bin/env bash


pushd "$HOME/configs" > /dev/null

git config -f .gitmodules --get-regexp '^submodule\..*\.path$' |
    while read path_key path
    do
        url_key=$(echo $path_key | sed 's/\.path/.url/')
        url=$(git config -f .gitmodules --get "$url_key")
        git submodule -q add $url $path
    done

echo "-> Updating vim bundles"
git submodule update --recursive 

popd > /dev/null
