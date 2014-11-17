echo 'Setting up CNP development environment, with support for branch parameters'

if [ "$1" != "" ]; then
	git clone -b $1 https://github.com/DemocracyApps/CNP.git cnp
	cd cnp

	echo "git checkout $1"
	git checkout $1
	cd ..
else
	git clone https://github.com/DemocracyApps/CNP.git cnp
fi

cd cnp/src/vendor

if [ "$2" != "" ]; then
	git clone -b $2 https://github.com/DemocracyApps/JSON.minify.git JSON.minify
else
	git clone https://github.com/DemocracyApps/JSON.minify.git JSON.minify
fi