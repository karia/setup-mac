#!/usr/bin/env bash

set -eu

cat <<EOS
------------------------------------------------------------
install Homebrew & ansbile
------------------------------------------------------------
EOS

if !(type "brew" > /dev/null 2>&1); then
  /bin/bash -c "$(curl -fsSL https://raw.githubusercontent.com/Homebrew/install/HEAD/install.sh)"
  echo 'eval "$(/opt/homebrew/bin/brew shellenv)"' >> ~/.zprofile
fi

if !(type "ansible" > /dev/null 2>&1); then
  brew install ansible
fi

cat <<EOS
------------------------------------------------------------
install ansible-galaxy collections & roles
------------------------------------------------------------
EOS

ansible-galaxy install -r requirements.yml

cat <<EOS
------------------------------------------------------------
install personal tools
------------------------------------------------------------
EOS

ansible-playbook -i localhost -c local personal-tools.yml

cat <<EOS
------------------------------------------------------------
setup completed!!
------------------------------------------------------------
EOS
