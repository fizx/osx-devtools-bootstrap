#!/bin/sh 
cd /tmp
curl -O http://svn.macports.org/repository/macports/downloads/MacPorts-1.7.1/MacPorts-1.7.1.tar.gz
tar -zxvf MacPorts-1.7.1.tar.gz
cd MacPorts-1.7.1
./configure && make && sudo make install || exit 1

echo 'export PATH=/opt/local/bin:$PATH' >> ~/.profile
echo 'export PATH=/opt/local/sbin:$PATH' >> ~/.profile
source ~/.profile

sudo port -v selfupdate
sudo /usr/bin/gem sources -r http://gems.github.com
sudo /usr/bin/gem sources -a http://gems.github.com

sudo port install git-core +svn \
                  postgresql83-server \
                  libxml2 \
                  libxslt \
                  mysql5 +server \
                  || exit 1                  
                  
sudo env ARCHFLAGS="-arch i386" /usr/bin/gem install libxml-ruby -- --with-xml2-config=/opt/local/bin/xml2-config                   
sudo env ARCHFLAGS="-arch i386" /usr/bin/gem install mysql -- --with-mysql-config=/opt/local/lib/mysql5/bin/mysql_config
PATH=$PATH:/opt/local/lib/postgresql83/bin/
sudo env ARCHFLAGS="-arch i386" /usr/bin/gem install --no-ri pg \
                  heroku \
                  rake \
                  rails \
                  mongrel \
                  chronic \
                  mocha \
                  fizx-uberchronic \
                  mislav-will_paginate \
                  mattetti-googlecharts \                  
                  || exit 1