###############################################################################
# Install prerequisites
###############################################################################
set -x

# aptitude configuration
APTITUDE_OPTIONS="-y"
export DEBIAN_FRONTEND=noninteractive

# run an aptitude update to make sure python-software-properties
# dependencies are found
apt-get update

# add the reddit ppa for some custom packages
apt-get install $APTITUDE_OPTIONS python-software-properties
apt-add-repository -y ppa:reddit/ppa

# pin the ppa -- packages present in the ppa will take precedence over
# ones in other repositories (unless further pinning is done)
cat <<HERE > /etc/apt/preferences.d/reddit
Package: *
Pin: release o=LP-PPA-reddit
Pin-Priority: 600
HERE

# add the datastax cassandra repos
echo deb http://debian.datastax.com/community stable main > /etc/apt/sources.list.d/cassandra.sources.list
wget -qO- -L https://debian.datastax.com/debian/repo_key | sudo apt-key add -

# grab the new ppas' package listings
apt-get update

# install prerequisites

cat <<PACKAGES | xargs apt-get install $APTITUDE_OPTIONS
netcat-openbsd
git-core

python-dev
python-setuptools
python-routes
python-pylons
python-boto
python-tz
python-crypto
python-babel
cython
python-sqlalchemy
python-beautifulsoup
python-chardet
python-psycopg2
python-pycassa
python-imaging
python-pycaptcha
python-amqplib
python-pylibmc
python-bcrypt
python-snudown
python-l2cs
python-lxml
python-zope.interface
python-kazoo
python-stripe
python-tinycss2
python-unidecode
python-mock
python-yaml

python-flask
geoip-bin
geoip-database
python-geoip

nodejs
node-less
node-uglify
gettext
make
optipng
jpegoptim

memcached
postgresql
postgresql-client
rabbitmq-server
cassandra=1.2.19
haproxy
nginx
stunnel
gunicorn
sutro
libpcre3-dev
PACKAGES