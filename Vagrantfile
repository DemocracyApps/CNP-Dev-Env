# -*- mode: ruby -*-
# vi: set ft=ruby :

# Vagrantfile API/syntax version. Don't touch unless you know what you're doing!
VAGRANTFILE_API_VERSION = "2"

Vagrant.configure(VAGRANTFILE_API_VERSION) do |config|
	config.vm.box = "precise64"
	config.vm.box_url = "http://files.vagrantup.com/precise64.box"
	config.vm.synced_folder ".", "/var/www"
	config.vm.network :private_network, ip: "192.168.33.23"

	# args[0]: specifies Apache User
	config.vm.provision :shell, :path => "install.sh", :args => ["vagrant"] 


	# Digital Ocean Provider Setup - overrides certain configuraiton options to support 
	# a hosted setup via a Digital Ocean droplet
	# 
	# Install:
	# 	You need to add a SSH private key to Digital Ocean, then specify it under 
	# 	override.ssh.private_key_path below.
	#
	# Usage: 
	# 	vagrant up --provider=digital_ocean
    config.vm.provider :digital_ocean do |provider, override|
    	override.vm.box = "digital_ocean"
		override.ssh.private_key_path = "~/.ssh/demapps_rsa"

		# args[0]: specifies Apache User
		override.vm.provision :shell, :path => "install.sh", :args => ["www-data"]

		# This disables the private networking directive from the default config
		override.vm.network :private_network, ip: "192.168.33.23", disabled: true

		# These are the DigitalOcean provider values 
		provider.token = "66fea2f5a02c2bb3cf15370e16773e282e18dfc762f346381574aa6436e549c7"
		provider.image = "12.04.5 x64"
		provider.region = "nyc2"
	end
end
