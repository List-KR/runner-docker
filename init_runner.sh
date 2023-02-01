# Rust Packages
RustPackages=("wasm-pack")

for i in "${RustPackages[@]}"
do
  cargo install "$i"
done

# npm packages
NpmPackages=("@actions/core" "@actions/github" "@actions/exec" "selenium-webdriver" "node-json-db" "ts-node" "tslib" "typescript" "adm-zip" "@types/node" "vuln-regex-detector" "safe-regex")

for i in "${NpmPackages[@]}"
do
  npm i -g "$i"
done

# GitHub Runner
cd ~
export runnerver="$(curl https://api.github.com/repos/actions/runner/releases/latest -s | jq .name -r | grep -Po '[0-9]+\.[0-9]+\.[0-9]+$')"
wget https://github.com/actions/runner/releases/download/v"$runnerver"/actions-runner-linux-x64-"$runnerver".tar.gz -O runner.tar.gz
tar -xvzf runner.tar.gz
rm runner.tar.gz
chmod -R +x ~