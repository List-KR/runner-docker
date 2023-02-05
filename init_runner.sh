# GitHub Runner
cd ~
export runnerver="$(curl https://api.github.com/repos/actions/runner/releases/latest -s | jq .name -r | grep -Po '[0-9]+\.[0-9]+\.[0-9]+$')"
wget https://github.com/actions/runner/releases/download/v"$runnerver"/actions-runner-linux-x64-"$runnerver".tar.gz -O runner.tar.gz
tar -xvzf runner.tar.gz
rm runner.tar.gz
chmod -R +x ~

# Set location of Npm installed globally
npm config set prefix /usr/local