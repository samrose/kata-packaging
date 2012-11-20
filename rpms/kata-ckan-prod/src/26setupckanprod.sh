#! /bin/sh
# remember: we are not root here (%ckanuser from the spec file)
set -x
if [ -f /tmp/kata-SKIP10 ]
then
  echo "Skipping 10"
  exit 0
fi
instloc=$1
cd $instloc
source pyenv/bin/activate
cd pyenv/src/ckan
myip=$(ip addr show dev eth0 | grep "inet " | sed -E "s/ +inet +([^/]+).+/\1/")
# TODO: needs to be really configurable
# ckanusermail kept from dev env
sed -e "s,\(ckan.site_url = http://\)[^ ]*,\1${myip}," development.ini > development.ini.1
mv development.ini.1 development.ini
paster --plugin=ckan db init
