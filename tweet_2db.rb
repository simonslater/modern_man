require 'tweetstream'
require 'data_mapper'

###Database Stuff#######
DataMapper::setup(:default, "sqlite3://#{Dir.pwd}/modern_man.db")

class Tweet
   include DataMapper::Resource
   property :id, Serial
   property :tweet, Text
   property :created_at, DateTime
end

class Response
   include DataMapper::Resource
   property :id, Serial
   property :response, Text
   property :tweet_id, Text
   property :created_at, DateTime
end

DataMapper.finalize
DataMapper.auto_upgrade!
########################

	
	TweetStream.configure do |config|
	config.consumer_key        = "acDtVJs4OGiP6BAV6sDFSw"
    config.consumer_secret     = "bFIhoMmoWwYvoNg23gCJsKRWv0k9TifvDrSHtcVGw"
    config.oauth_token        = "286226479-Kk8hRLRwF3wMB5NKIlDjC3a6WnmRJCLUTWyS8Qfg"
    config.oauth_token_secret = "gOGMq4zCwJa2VRDn60HWY6YFf8jq8nMmiBXynXr0ZzYW9"
    config.auth_method        = :oauth
    end

TweetStream::Client.new.track('modern') do |twt|

 puts "#{twt.text}"
 t = Tweet.new
 t.tweet = twt.text
	# Save it to the database
  t.save 
end