#!/bin/sh
#!/bin/bash

# packages lists
AptPackages=("wget" "nodejs" "npm" "git" "nano" "curl" "tar" "jq" "grep" "vim" "sudo" "7zip")

# Install APT packages
apt update
apt upgrade -y
apt purge $(dpkg -l | grep '^rc' | awk '{print $2}')
for i in "${AptPackages[@]}"
do
  apt install -y "$i"
done

# Dotnet
wget https://dot.net/v1/dotnet-install.sh
chmod +x dotnet-install.sh
bash dotnet-install.sh --channel STS
rm dotnet-install.sh

# npm packages
NpmPackages=("@actions/core" "@actions/github" "@actions/exec" "selenium-webdriver" "node-json-db" "ts-node" "tslib" "typescript" "adm-zip" "chance" "safe-regex" "benchmark" "openpgp" "sha.js" "regexp-tree")
NpmDevPackges=("@types/safe-regex" "@types/node" "@types/chance" "@types/benchmark" "@types/selenium-webdriver" "@types/adm-zip" "@types/sha.js")

for i in "${NpmPackages[@]}"
do
  npm i -g "$i"
done

for i in "${NpmDevPackges[@]}"
do
  npm i -g -D "$i"
done

# DNS Lookup
export dnslookupver="$(curl https://api.github.com/repos/ameshkov/dnslookup/releases/latest -s | jq .name -r | grep -Po '[0-9]+\.[0-9]+\.[0-9]+$')"
wget https://github.com/ameshkov/dnslookup/releases/download/v"$dnslookupver"/dnslookup-linux-amd64-v"$dnslookupver".tar.gz -O dnslookup.tar.gz
tar -xvzf dnslookup.tar.gz
mv linux-amd64/dnslookup /bin/dnslookup
chmod +x /bin/dnslookup
rm -r linux-amd64
rm -r dnslookup.tar.gz

# GitHub CLI
export dnslookupver="$(curl https://api.github.com/repos/cli/cli/releases/latest -s | jq .name -r | grep -Po '[0-9]+\.[0-9]+\.[0-9]+$')"
wget https://github.com/cli/cli/releases/download/v"$dnslookupver"/gh_"$dnslookupver"_linux_amd64.deb -O gh_cli.deb
dpkg -i gh_cli.deb
rm -r gh_cli.deb