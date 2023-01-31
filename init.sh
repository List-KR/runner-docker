#!/bin/sh
#!/bin/bash

# APT Pre-packages
AptPrePackages=("wget" "nodejs" "npm" "git" "nano" "curl" "tar" "jq" "grep")
NpmPackages=("@actions/core" "@actions/github" "@actions/exec" "selenium-webdriver" "node-json-db" "ts-node" "tslib" "typescript" "adm-zip" "@types/node" "vuln-regex-detector" "safe-regex")

# Install APT packages
apt update
apt upgrade -y
apt purge $(dpkg -l | grep '^rc' | awk '{print $2}')
for i in "${AptPrePackages[@]}"
do
  apt install -y "$i"
done

# Dotnet
wget https://dot.net/v1/dotnet-install.sh
chmod +x dotnet-install.sh
bash dotnet-install.sh --channel STS
rm dotnet-install.sh

# Install NPM packages
for i in "${NpmPackages[@]}"
do
  npm i -g "$i"
done

# DNS Lookup
export dnslookupver="$(curl https://api.github.com/repos/ameshkov/dnslookup/releases/latest -s | jq .name -r | grep -Po '[0-9]+\.[0-9]+\.[0-9]+$')"
wget https://github.com/ameshkov/dnslookup/releases/download/v"$dnslookupver"/dnslookup-linux-amd64-v"$dnslookupver".tar.gz -O dnslookup.tar.gz
tar -xvzf dnslookup.tar.gz
mv linux-amd64/dnslookup /bin/dnslookup
chmod +x /bin/dnslookup
rm -r linux-amd64

# Create account
useradd --create-home runner