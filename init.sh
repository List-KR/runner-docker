#!/bin/bash

# APT Pre-packages
AptPrePackages=("wget" "nodejs" "npm" "git" "nano" "curl" "tar")
NpmPackages=("@actions/core" "@actions/github" "@actions/exec" "selenium-webdriver" "node-json-db" "typescript" "adm-zip" "@types/node")

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

dnslookupver=${{ curl https://api.github.com/repos/ameshkov/dnslookup/releases/latest -s | jq .name -r | grep -Po '[0-9]+\.[0-9]+\.[0-9]+$' }}
wget https://github.com/ameshkov/dnslookup/releases/download/v${{dnslookupver}}/dnslookup-linux-amd64-v${{dnslookupver}}.tar.gz -o dnslookup.tar.gz
tar -xvzf dnslookup.tar.gz -C dnslookup
mv dnslookup/linux-amd64/dnslookup /bin/dnslookup
chmod +x /bin/dnslookup