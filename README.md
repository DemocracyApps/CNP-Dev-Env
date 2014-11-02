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



