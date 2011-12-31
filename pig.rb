require 'rubygems'
require 'tweetstream'
require 'yajl'
require 'twitter'
require 'colored'

# secret tokens (move me)
CONSUMER_KEY = ENV['CONSUMER_KEY']
CONSUMER_SECRET = ENV['CONSUMER_SECRET']
OAUTH_TOKEN = ENV['OAUTH_TOKEN']
OAUTH_TOKEN_SECRET = ENV['OAUTH_TOKEN_SECRET']

#config
TERMS = "beat level angry birds cant, beat level angry birds can't, beat level angry birds cannot"

# configure tweetstream instance
TweetStream.configure do |config|
  config.consumer_key = CONSUMER_KEY
  config.consumer_secret = CONSUMER_SECRET
  config.oauth_token = OAUTH_TOKEN
  config.oauth_token_secret = OAUTH_TOKEN_SECRET
  config.auth_method = :oauth
  config.parser   = :yajl
end

# configure twitter gem instance
Twitter.configure do |config|
  config.consumer_key = CONSUMER_KEY
  config.consumer_secret = CONSUMER_SECRET
  config.oauth_token = OAUTH_TOKEN
  config.oauth_token_secret = OAUTH_TOKEN_SECRET
end

@client = TweetStream::Client.new

@client.on_error do |message|
  puts "ERROR: #{message}"
end

@client.track(TERMS) do |status|
    puts " ** #{status.screen_name}".green + status.text.white
end


