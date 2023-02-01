#!/bin/sh
#!/bin/bash

# packages lists
AptPackages=("wget" "nodejs" "npm" "git" "nano" "curl" "tar" "jq" "grep" "vim")

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

# DNS Lookup
export dnslookupver="$(curl https://api.github.com/repos/ameshkov/dnslookup/releases/latest -s | jq .name -r | grep -Po '[0-9]+\.[0-9]+\.[0-9]+$')"
wget https://github.com/ameshkov/dnslookup/releases/download/v"$dnslookupver"/dnslookup-linux-amd64-v"$dnslookupver".tar.gz -O dnslookup.tar.gz
tar -xvzf dnslookup.tar.gz
mv linux-amd64/dnslookup /bin/dnslookup
chmod +x /bin/dnslookup
rm -r linux-amd64
rm -r dnslookup.tar.gz