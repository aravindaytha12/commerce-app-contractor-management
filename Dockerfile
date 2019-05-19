# === Step 1 ===
FROM quay.io/gannett/commerce-ruby:2.4.4

# === Step 2 ===
# create a user to run the processes...
RUN groupadd appuser && \
    useradd -rg appuser appuser

# === Step 3 ===
# Run Bundle in a cache efficient way
WORKDIR /tmp
COPY Gemfile /tmp/
COPY Gemfile.lock /tmp/
USER root
RUN bundle install

# === Step 4 ===
COPY . /opt/rubyapp
WORKDIR /opt/rubyapp/

# === Step 5 ===
RUN bundle exec rake assets:precompile

# === Step 6 ===
RUN chown -R appuser /opt/rubyapp/

USER appuser

# === Step 7 ===
CMD docker-files/start-webapp.sh
