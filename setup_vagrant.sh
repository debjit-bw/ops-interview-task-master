#!/bin/bash

# Set the Vagrant box name
VAGRANT_BOX_NAME="ubuntu/bionic64"

# Check if Vagrant is installed
if ! command -v vagrant >/dev/null; then
  echo "Vagrant is not installed. Please install Vagrant and try again."
  exit 1
fi

# Check if VirtualBox is installed
if ! command -v virtualbox >/dev/null; then
  echo "VirtualBox is not installed. Please install VirtualBox and try again."
  exit 1
fi

# Check if the Vagrant box is installed
if ! vagrant box list | grep -q "$VAGRANT_BOX_NAME"; then
  echo "The Vagrant box '$VAGRANT_BOX_NAME' is not installed. Installing now..."
  vagrant box add "$VAGRANT_BOX_NAME"
fi

# Create a Vagrantfile
if [ ! -f Vagrantfile ]; then
  echo "Creating a Vagrantfile..."
  cat <<EOF > Vagrantfile
# -*- mode: ruby -*-
# vi: set ft=ruby :

VAGRANT_BOX = 'ubuntu/bionic64'

Vagrant.configure("2") do |config|
  config.vm.box = VAGRANT_BOX

  config.vm.provision "ansible" do |ansible|
    ansible.verbose = "v"
    ansible.playbook = "provision.yml"
  end
end
EOF
fi

# Check if the Vagrant box is running
if ! vagrant status | grep -q "running"; then
  echo "Starting the Vagrant box..."
  vagrant up
else
# Start the Vagrant box
  echo "The Vagrant box is already running. Cheers!"
  exit 0
fi

# Check if the Vagrant box is running
if ! vagrant status | grep -q "running"; then
  echo "There was an error starting the Vagrant box. Please check the Vagrant logs for more information."
  exit 1
fi

# Echo success message
echo "The Vagrant box is now running!"