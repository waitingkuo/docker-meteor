# -*- mode: ruby -*-
# vi: set ft=ruby :

BOX_NAME = ENV["BOX_NAME"] || "raring"
BOX_URI = ENV["BOX_URI"] || "http://cloud-images.ubuntu.com/vagrant/raring/current/raring-server-cloudimg-amd64-vagrant-disk1.box"


VAGRANTFILE_API_VERSION = "2"

Vagrant.configure(VAGRANTFILE_API_VERSION) do |config|

  config.vm.box = "raring"
  config.vm.network :private_network, ip: "192.168.66.66"
  config.vm.synced_folder ".", "/vagrant"
  config.vm.provision :shell, :path => "bootstrap.sh"

end

