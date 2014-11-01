CNP-Dev-Env
===========

Test/development environment for the Community Narratives Platform. 

##Instructions for Setting Up

These instructions assume that you are working in OSX and that commands are being run in a terminal window.

1. Install Vagrant: http://www.vagrantup.com/
2. Install VirtualBox: https://www.virtualbox.org/wiki/Downloads
3. Install Git: http://git-scm.com/downloads
4. Navigate to the directory where you want to create the development directory. Clone this repository 
   to a directory called CNP:

        git clone https://github.com/DemocracyApps/CNP-Dev-Env.git CNP

5. Navigate to the CNP directory and clone the CNP platform directory:

        git clone https://github.com/DemocracyApps/CNP.git cnp

6. From the CNP directory, run the following commands to download, configure and start the virtual server and log in:

        vagrant up
        vagrant ssh

   The first command may take a few minutes. The second command will log you into the development server. Running the
   command 'uname -a' should give you output similar to:

        Linux precise64 3.2.0-23-generic #36-Ubuntu SMP Tue Apr 10 20:39:51 UTC 2012 x86_64 x86_64 x86_64 GNU/Linux

   Note that the CNP directory is shared with this server - on the server it corresponds to the /vagrant directory.

**NOTE: the IP address of the virtual machine is set in the Vagrant file - you may change it if you wish.**

7. On your local machine (laptop), edit the /etc/hosts file and create an alias, for example:

        192.168.33.22   cnp.loc

   Verify that entering the URL 'cnp.dev' in a browser gives you the Apache2 Debian Default Page.
