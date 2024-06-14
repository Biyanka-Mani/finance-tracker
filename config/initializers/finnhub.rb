require 'finnhub_ruby'

FinnhubRuby.configure do |config|
  config.api_key['api_key'] = Rails.application.credentials.FinnhubRuby[:access_key_id]
end

FINNHUB_CLIENT = FinnhubRuby::DefaultApi.new