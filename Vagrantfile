# -*- mode: ruby -*-
# vi: set ft=ruby :

# Vagrantfile API/syntax version. Don't touch unless you know what you're doing!
VAGRANTFILE_API_VERSION = "2"

Vagrant.configure(VAGRANTFILE_API_VERSION) do |config|
  config.vm.box = "precise64"
  config.vm.box_url = "http://files.vagrantup.com/precise64.box"
  config.vm.network :private_network, ip: "192.168.33.23"
  config.vm.provision :shell, :path => "install.sh"
  config.vm.synced_folder ".", "/var/www"
end


  #prc testing
  config.vm.box = "digital_ocean"

  #TODO: Conditional Logic for DO vs Local Environment
  #TODO: Specify a specific branch
  #TODO: Allow multiple deploy types - hardcoded dev / live deploy location? 


  config.ssh.private_key_path = "~/.ssh/demapps_rsa"
	config.vm.provider :digital_ocean do |provider|
		
		# TODO: revoke this old token
		# provider.client_id = "cb40ab1af65fbbb153e342caefd57505"
		# provider.api_key = "729ac3fb5250ed445230784b978c849e"
		
		provider.token = "66fea2f5a02c2bb3cf15370e16773e282e18dfc762f346381574aa6436e549c7"
		provider.image = "12.04.5 x64"
		provider.region = "nyc2"
	  


	  	config.vm.provision :shell, :path => "install.sh"
	    config.vm.synced_folder ".", "/var/www"

	  end

