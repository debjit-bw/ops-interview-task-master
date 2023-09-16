# -*- mode: ruby -*-
# vi: set ft=ruby :

VAGRANT_BOX = 'ubuntu/focal64'

Vagrant.configure("2") do |config|
  config.vm.box = VAGRANT_BOX

  config.vm.provision "ansible" do |ansible|
    ansible.verbose = "v"
    ansible.playbook = "provision.yml"
  end
end