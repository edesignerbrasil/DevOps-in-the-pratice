# -*- mode: ruby -*-
# vi: set ft=ruby :

VAGRANTFILE_API_VERSION = "2"

Vagrant.configure(VAGRANTFILE_API_VERSION) do |config|
  
  config.vm.box = "hashicorp/precise32"

  config.vm.define :db do |db_config|
    db_config.vm.network 
      :private_network, 
      :ip => "192.168.33.10"
      
  end

  config.vm.define :web do |web_config|
    web_config.vm.network 
      :private_network, 
      :ip => "192.168.33.12"

  end


end
