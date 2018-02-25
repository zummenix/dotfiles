#!/usr/bin/env bash

if [ -x "$(command -v brew)" ]; then
    echo "Updating homebrew"
    brew update
else
    echo "Installing homebrew"
    /usr/bin/ruby -e "$(curl -fsSL https://raw.githubusercontent.com/Homebrew/install/master/install)"
fi

# Install/cleanup dependencies using Brewfile
brew bundle -v
brew bundle cleanup -v

# Run ansible playbook
ansible-playbook -i inventory playbook.yml
