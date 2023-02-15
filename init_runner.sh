# GitHub Runner
cd ~
if [ "$(uname -m)" == "x86_64" ]
then
  export runnerarch="x64"
fi
if [ "$(uname -m)" == "aarch64" ]
then
  export runnerarch="arm64"
fi
export runnerver="$(curl https://api.github.com/repos/actions/runner/releases/latest -s | jq .name -r | grep -Po '[0-9]+\.[0-9]+\.[0-9]+$')"
wget https://github.com/actions/runner/releases/download/v"$runnerver"/actions-runner-linux-"$runnerarch"-"$runnerver".tar.gz -O runner.tar.gz
tar -xvzf runner.tar.gz
rm runner.tar.gz
chmod -R +x ~

# Set location of Npm installed globally
npm config set prefix /usr/local