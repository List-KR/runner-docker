#!/bin/bash

# APT Pre-packages
AptPrePackages = ("wget" "nodejs" "npm" "git" "nano")
NpmPackages = ("@actions/core" "@actions/github" "@actions/exec" "selenium-webdriver")

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

# Create runner account

useradd --create-home runner