#!/bin/sh

# set the default values...
RAILS_ENV=${RAILS_ENV:=development}
export VAULT_ADDR='https://vault.service.us-east-1.gciconsul.com:8200'

if [[ -z $VAULT_TOKEN ]]; then
  export VAULT_TOKEN=$(cat /var/run/secrets/vault-volume/token)
fi

# write environment variables into configs
echo "Replacing placeholders in config files..."
sed -i "s/{RAILS_ENV}/${RAILS_ENV}/g" /opt/rubyapp/docker-files/secrets.ctmpl

consul-template -template "/opt/rubyapp/docker-files/secrets.ctmpl:/opt/rubyapp/config/secrets.yml" -once

if [[ ${RAILS_ENV} == 'production' ]]; then
  sed -i "s/{RAILS_ENV}/${RAILS_ENV}/g" /opt/rubyapp/docker-files/newrelic.ctmpl
  consul-template -template "/opt/rubyapp/docker-files/newrelic.ctmpl:/opt/rubyapp/config/newrelic.yml" -once
fi

# run migrations and compile assets
echo "Running Migrations with env: ${RAILS_ENV}"
RAILS_ENV=${RAILS_ENV} bundle exec rake db:migrate
