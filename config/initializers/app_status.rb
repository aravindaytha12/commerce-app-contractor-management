AppStatus::ResourceCollection.configure do |config|

  config.add_dependency('Mail SMTP server') do
    Net::SMTP.start('relay.ent.gci', 25) {|smtp| smtp.started? }
  end

  config.add_dependency('Vault renew token', expires_in: 23.hours) do
    Vault.auth_token.renew_self
    true
  end

end
