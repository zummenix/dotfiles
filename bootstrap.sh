#!/usr/bin/env bash

if [ -x "$(command -v brew)" ]; then
    echo "Update homebrew"
    brew update
else
    echo "Install homebrew"
    /usr/bin/ruby -e "$(curl -fsSL https://raw.githubusercontent.com/Homebrew/install/master/install)"
fi

if [ -x "$(command -v ansible)" ]; then
    echo "Update ansible"
    brew upgrade ansible
else
    echo "Install ansible"
    brew install ansible
fi
