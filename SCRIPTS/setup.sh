echo -e "\nSetting up CNP development environment, with support for branch parameters.\n"

cnp_repo="https://github.com/DemocracyApps/CNP.git"
cnp_dir="cnp"
cnp_branch="$1"

json_repo="https://github.com/DemocracyApps/JSON.minify.git"
json_dir="JSON.minify"
json_parent_dir="cnp/src/vendor"
json_branch="$2"

echo "Repository URL:			$cnp_repo"
echo "Repository Directory:		$cnp_dir"

echo -e "\nChecking for existing directory"

# If the repository exists, do a pull
# Otherwise, do a git clone
if cd $cnp_dir; then 
	echo "Directory already exists"
	echo "Updating Repo" 
	git pull
else 
	if [ "$cnp_branch" != "" ]; then
		echo "Cloning Repo on branch $cnp_branch" 
		git clone -b $cnp_branch $cnp_repo $cnp_dir
	else
		echo "Cloning Repo" 
		git clone $cnp_repo $cnp_dir
	fi
	cd $cnp_dir
fi

if [ "$cnp_branch" != "" ]; then
	# Switch to the specified branch, even if we're already on it. 
	echo -e "\nChecking out branch: $cnp_branch"
	git checkout $cnp_branch
fi
cd ..

echo -e "\n\nProcessing JSON.minify repository"

cd $json_parent_dir

echo -e "Temporary fix: Cloning the JSON repository each time to make sure it exists."
git clone $json_repo $json_dir

echo -e "\nChecking for existing directory"

# If the repository exists, do a pull
# Otherwise, do a git clone
if cd $json_dir; then 
	echo "Directory already exists"
	echo "Updating Repo" 
	git pull
else 
	if [ "$json_branch" != "" ]; then
		echo "Cloning Repo on branch $json_branch" 
		git clone -b $json_branch $json_repo $json_dir
	else
		echo "Cloning Repo" 
		git clone $json_repo $json_dir
	fi
	cd $json_dir
fi

if [ "$json_branch" != "" ]; then
	# Switch to the specified branch, even if we're already on it. 
	echo -e "\nChecking out branch: $json_branch"
	git checkout $json_branch
	cd ..
fi

# Get Laravel set up and running
echo 'Setting up laravel and CNP application'
cd /var/www/cnp/
composer install
sudo chmod -R 777 /var/www/cnp/app/storage
php artisan migrate

# Need to restart with the directories above created
sudo service apache2 restart

# Now let's prepare a place for the analytics engine
sudo mkdir /opt/democracyapps
sudo mkdir /opt/democracyapps/lib
sudo mkdir /var/log/democracyapps
sudo mkdir /var/log/democracyapps/ga

sudo su postgres -c 'psql -d cnp -c "grant select on elements to ga;"'
sudo su postgres -c 'psql -d cnp -c "grant select on relations to ga;"'
sudo su postgres -c 'psql -d cnp -c "grant select,update on analyses to ga;"'
sudo su postgres -c 'psql -d cnp -c "grant select,insert,update on analysis_outputs to ga;"'
sudo su postgres -c 'psql -d cnp -c "grant select,insert,update on analysis_sets to ga;"'
sudo su postgres -c 'psql -d cnp -c "grant select,insert,update on analysis_set_items to ga;"'
sudo service postgresql restart


# Install and configure queueing system and supervisor
echo 'Configure and start the queueing system'
sudo sed -i "s/#START=yes/START=yes/" /etc/default/beanstalkd
sudo service beanstalkd start
sudo cp /vagrant/FILES/queue.conf /etc/supervisor/conf.d
sudo unlink /var/run/supervisor.sock
sudo service supervisor start
echo 'Running supervisorctl'
sudo supervisorctl reread
sudo supervisorctl add queue
sudo supervisorctl start queue

echo -e "\nFinished\n"
echo -e "**************************************************"
echo -e "***************************************(***********"
echo -e "** NOTE: In a production environment you should **"
echo -e "**       restrict network access to the DB in   **"
echo -e "**       pg_hba.conf and postgresql.conf in     **"
echo -e "**       /etc/postgresql/9.1/main/              **"
echo -e "**************************************************"
echo -e "**************************************************"


