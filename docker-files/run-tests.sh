#!/bin/sh

. /opt/rubyapp/docker-files/init.sh

echo 'Running tests...'
cd /opt/rubyapp
RAILS_ENV=test bundle exec rake spec
