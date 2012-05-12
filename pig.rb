require 'rubygems'
require 'tweetstream'
require 'oj'
require 'twitter'
require 'colored'

# secret tokens (move me)
CONSUMER_KEY = ENV['CONSUMER_KEY']
CONSUMER_SECRET = ENV['CONSUMER_SECRET']
OAUTH_TOKEN = ENV['OAUTH_TOKEN']
OAUTH_TOKEN_SECRET = ENV['OAUTH_TOKEN_SECRET']

#config
TERMS = ["beat level angry birds cant", "beat level angry birds can't", "beat level angry birds cannot"]

#
# configure tweetstream instance
#
TweetStream.configure do |config|
  config.consumer_key = CONSUMER_KEY
  config.consumer_secret = CONSUMER_SECRET
  config.oauth_token = OAUTH_TOKEN
  config.oauth_token_secret = OAUTH_TOKEN_SECRET
  config.auth_method = :oauth
  config.parser   = :oj
end

#
# configure twitter gem instance
#
Twitter.configure do |config|
  config.consumer_key = CONSUMER_KEY
  config.consumer_secret = CONSUMER_SECRET
  config.oauth_token = OAUTH_TOKEN
  config.oauth_token_secret = OAUTH_TOKEN_SECRET
end

#
# generate the snort msg
#
def snortle
  phrases=["oink", "snort", "heh heh"]
  snort = ""
  rand(3..8).times do
    snort += phrases.sample.upcase + " "
  end
  snort += "HEH HEH HEH" #always end with laugh
end

#
# instantiate client and main logic
#
@client = TweetStream::Client.new
@client.on_error do |message|
  puts "ERROR: #{message}"
end

$stdout.sync = true
LIVE = true
@client.track(TERMS) do |status|
    puts " ** #{status.user.screen_name} ".green + status.text.white + " (\##{status.id.to_s})"
    msg = "@#{status.user.screen_name} #{snortle}..."
    puts " -> ".red + msg
    if LIVE
        response = Twitter.update(msg, :in_reply_to_status_id => status.id)
        puts " -> ".red + "posted as http://twitter.com/#{response.user.screen_name}/status/#{response.id.to_s}"
    end
end


