#!/bin/bash

# Environment detechion

if [[ "$OSTYPE" == "darwin"* ]]; then
  OS=osx
elif [[ "$OSTYPE" == "freebsd"* ]]; then
  OS=freebsd
elif [[ "$OSTYPE" == "linux-gnu" ]]; then
  OS=linux
  if [[ -f /etc/redhat-release ]]; then
    DISTRO=redhat
  elif [[ -f /etc/debian_version ]]; then
    DISTRO=debian
  else
    echo "Not supported!"
    exit
  fi
else
  echo "$OSTYPE Not supported!"
  exit
fi

# ask some stuff
read -p "Name (format: Firstname Lastname): " -r
NAME=$REPLY
read -p "Email address: " -r
EMAIL=$REPLY
read -p "Install IE virtualbox VM's (install VirtualBox and extensions first)? " -n 1 -r
echo
if [[ $REPLY =~ ^[Yy]$ ]]; then
    IEVMS=true
fi

###############################################################################
## os X                                                                       #
###############################################################################

if [[ "$OSTYPE" == "darwin"* ]]; then
  # show hidden files by default
  defaults write com.apple.Finder AppleShowAllFiles YES

  # install homebrew http://brew.sh/
  if ! hash brew 2>/dev/null; then
    echo "Starting homebrew installation..."
    ruby -e "$(curl -fsSL https://raw.github.com/Homebrew/homebrew/go/install)"
  fi

  echo "Updating brew formulas..."
  brew update >/dev/null

  # Install some programs
  echo "Installing packages..."
  PACKAGES=(augeas unrar pwgen tree mobile-shell node)
  for package in "$PACKAGES"
  do
    brew install --quiet $package
  done
  echo "Finished package installation"
fi

# node.js helpers
npm install -g "paveq/node_helpers"

# git
if hash git 2>/dev/null; then
git config --global user.name $NAME
git config --global user.email $EMAIL
fi

# mercurial TODO
#if hash hg 2>/dev/null; then
#git config --global usera.name $NAME
#git config --global user.email $EMAIL
#fi

# install IE virtual machines
if [[ "$IEVMS" == true ]]; then
curl -s https://raw.github.com/xdissent/ievms/master/ievms.sh | env IEVMS_VERSIONS="8 9 10 11" bash
fi
