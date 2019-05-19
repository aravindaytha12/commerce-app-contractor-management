#!/bin/sh

. /opt/rubyapp/docker-files/init.sh

# start Rails server
echo "Starting Rails"
cd /opt/rubyapp/
RAILS_ENV=${RAILS_ENV} bundle exec rails s -b 0.0.0.0 -p 3001
