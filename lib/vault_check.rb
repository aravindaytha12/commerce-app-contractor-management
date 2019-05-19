require 'vault'
require 'uri'
require 'net/http'

Vault.configure do |config|
  # The address of the Vault server, also read as ENV["VAULT_ADDR"]
  config.address = "https://vault.service.us-east-1.gciconsul.com:8200"

  # Use SSL verification, also read as ENV["VAULT_SSL_VERIFY"]
  config.ssl_verify = false
end

file_name = "token_check_timestamp.txt"
last_check =
  if File.exists?(file_name)
    Time.parse(File.read(file_name))
  else
    t = Time.now
    f = File.new(file_name, 'w')
    f.write(t.to_s)
    f.close
    t
  end

# Read vault token from folder where vault_init during app deployment has written it
Vault.token = File.read('/var/run/secrets/vault-volume/token')

if Time.now - last_check > 3600
  vt = Vault.auth_token.lookup_self
  # if the time to live is less than 2/3 of the ttl at token creation, then renew the token...
  if vt.data[:ttl] - vt.data[:creation_ttl] * 2/3 < 0
    p "#{Time.now} -> Token TTL (#{vt.data[:ttl]}) < 2/3 of creation TTL (#{vt.data[:creation_ttl]}), refreshing token #{Vault.token}"
    Vault.auth_token.renew_self
  else
    p "#{Time.now} -> Token has #{vt.data[:ttl].to_i/60} minutes to live, not refreshing token."
  end
  f = File.open(file_name, "w")
  f.write(Time.now.to_s)
  f.close
else
  p "#{Time.now} -> Last check within an hour, not refreshing token. Last check: #{last_check}."
end

uri = URI.parse("http://localhost:3001/status/base")
response = Net::HTTP.get_response(uri)
if response.code == "200"
  p "#{Time.now} -> localhost:3001/status/base is up"
else
  p "#{Time.now} -> localhost:3001/status/base is down: #{response.code}"
end
