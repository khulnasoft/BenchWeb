#!/usr/bin/env bash
#
# Prepares a virtual machine for running BW

# A shell provisioner is called multiple times
if [ ! -e "~/.firstboot" ]; then

  # Workaround mitchellh/vagrant#289
  echo "grub-pc grub-pc/install_devices multiselect     /dev/sda" | sudo debconf-set-selections

  # Install prerequisite tools
  echo "Installing docker"
  curl -fsSL https://download.docker.com/linux/ubuntu/gpg | sudo apt-key add -
  sudo add-apt-repository "deb [arch=amd64] https://download.docker.com/linux/ubuntu $(lsb_release -cs) stable"
  sudo apt-get update -yqq
  sudo apt-get install -yqq docker-ce
  sudo usermod -aG docker vagrant

  # Setting up passwordless sudo
  echo "vagrant ALL=(ALL:ALL) NOPASSWD: ALL" | sudo tee -a /etc/sudoers

  sudo chown vagrant:vagrant ~/BenchWeb
  cd ~/BenchWeb

  # Setup a nice welcome message for our guest
  echo "Setting up welcome message"
  sudo rm -f /etc/update-motd.d/51-cloudguest
  sudo rm -f /etc/update-motd.d/98-cloudguest

  sudo cat <<EOF > motd
Welcome to the BenchWeb project!

  You can get lots of help:
    $ bw --help

  You can run a test like:
    $ bw --mode verify --test gemini

  This Vagrant environment is already setup and ready to go.
EOF

  cat <<EOF > /home/vagrant/.bash_aliases
alias bw="/home/vagrant/BenchWeb/bw"
EOF

  sudo mv motd /etc/
  sudo chmod 777 /var/run/docker.sock
fi
