CNP-Dev-Env
===========

Test/development environment for the Community Narratives Platform. 

##Instructions for Setting Up

These instructions assume that you are working in OSX and that commands are being run in a terminal window.

1. Install Vagrant: http://www.vagrantup.com/
2. Install VirtualBox: https://www.virtualbox.org/wiki/Downloads
3. Install Git: http://git-scm.com/downloads
4. Navigate to the parent directory where you want to create the development 
   directory and clone this repository to a directory called CNP:

        git clone https://github.com/DemocracyApps/CNP-Dev-Env.git CNP

5. Navigate to the CNP directory and run the following commands:

        ./SCRIPTS/setup_osx.sh
        vagrant up

   This will take a few minutes. It will set up the development server and start it running. You can
   log into the server at any point by running 'vagrant ssh' from this directory. For other commands,
   check the vagrant documentation. Note that the CNP directory is shared with this server - on the server it corresponds to the /vagrant directory.

6. On your *local* machine (laptop), add the following line to the /etc/hosts file:

      192.168.33.23  cnp.dev
      
   You should now be able to type 'cnp.dev' into your browser and see the Community Narratives Platform.
   You can immediately log in using the 'Demo Login' link.

##Other Notes

   The IP address is set to 192.168.33.23 in the Vagrantfile. If you wish to use a different
   IP, change it there and use the new value in your local /etc/hosts file.

   The system is set up with a Demo User with a special login link on the login page. If you wish
   to have users log in using Twitter or Facebook, you will need to add the appropriate client IDs and client secrets in CNP/cnp/app/config/packages/artdarek/oauth-4-laravel/config.php.


## PRC Notes

We have added support for Digital Ocean as a provider. You can deploy CNP to Digital Ocean and deploy updates to the newly created machine. 

**Note:** You cannot currently run both a local (VirtualBox) and DigitalOcean version of the same machine from the same directory. However, if you clone this development repository twice into two local directories, this does appear to work. 

**Double Note: Do not put your Digital Ocean access token in any files committed to Github!**

1. **Digital Ocean SSH Key:**

        # Setup a SSH-Key using one of the many guides on the internet, for example:
        ssh-keygen -t rsa -C "email@example.com"
        cat ~/.ssh/id_rsa.pub

        # Add it to your DigitalOcean account: https://cloud.digitalocean.com/ssh_keys

        # Specify the name of the key file on line 24 of the Vagrantfile
        override.ssh.private_key_path = "~/.ssh/demapps_rsa"

2. **Digital Ocean Access Token:**

        # You also need to set your access token as an environmental variable, available here: 
        # https://cloud.digitalocean.com/settings/applications

        export DIGITAL_OCEAN_ACCESS_TOKEN="{YOUR_DO_TOKEN}"

        # To make this permanent, add it to your ~/.bash_profile file and source ~/.bash_profile
        
        nano ~/.bash_profile
        # add the above line - export DIGITAL_OCEAN_ACCESS_TOKEN="{YOUR_DO_TOKEN}"
        source ~/.bash_profile

2. **Booting an instance on DigitalOcean:**

        vagrant up provider=digital_ocean

        # You can then do all the normal vagrant commands, without specifying provider
        vagrant ssh         # SSH to the Digital Ocean machine 
        vagrant reload      # Reboot the instance
        vagrant provision   # Re-provision the server (run install.sh) 
        vagrant destroy     # Remove the instance from Digital Ocean

3. **Updating Code or changing branches:**

        # use default branches
        vagrant ssh -c 'cd /var/www; ./SCRIPTS/setup_osx.sh'

        # specify just CNP branch
        vagrant ssh -c 'cd /var/www; ./SCRIPTS/setup_osx.sh extv1'                      

        # specify both CNP and JSON branches like this:
        vagrant ssh -c 'cd /var/www; ./SCRIPTS/setup_osx.sh {cnp_branch} {json_branch}' 

4. **Updating Server:**

        vagrant provision     #re-run the provisioning scripts
        vagrant reload        #reboot the DigitalOcean 'droplet'

