#!/bin/bash

# APT Pre-packages
AptPrePackages=("wget" "nodejs" "npm" "git" "nano")
NpmPackages=("@actions/core" "@actions/github" "@actions/exec" "selenium-webdriver")

# Install pre-packages

apt update
for i in "${AptPrePackages[@]}"
do
  apt install -y "$i"
done
for i in "${NpmPackages[@]}"
do
  npm i -g "$i"
done

NONINTERACTIVE=1 /bin/bash -c "$(curl -fsSL https://raw.githubusercontent.com/Homebrew/install/HEAD/install.sh)"
brew install ameshkov/tap/dnslookup