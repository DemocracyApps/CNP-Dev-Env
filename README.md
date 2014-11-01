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
        cp ./FILES/config.php ./cnp/app/config/packages/artdarek/oauth-4-laravel/config.php

    then fill in the appropriate client IDs and client secrets for Twitter or Facebook authentication.
    (or talk to EJ about borrowing his).

6. Still from the CNP directory, run the following command (if you wish to change the IP address of the
   CNP dev server, change it in Vagrantfile before running this command and use for /etc/hosts edit below
   as well):

        vagrant up

   This will take a few minutes. It will set up the development server and start it running. You can
   log into the server at any point by running 'vagrant ssh' from this directory. For other commands,
   check the vagrant documentation. Note that the CNP directory is shared with this server - on the server it corresponds to the /vagrant directory.

7. On your *local* machine (laptop), add the following line to the /etc/hosts file:

      192.168.33.23  cnp.dev

   If you wish to change the IP address, you must also change it in the Vagrantfile.
   

