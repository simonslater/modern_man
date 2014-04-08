configure :development do
	set :database, "sqlite3:modern_man.db"
	set :show_exceptions, true 
end

configure :production do
ActiveRecord::Base.establish_connection(ENV['DATABASE_URL'] || 'postgres:localhost/mydb')

end

def streaming_twitter
	TweetStream.configure do |config|
	config.consumer_key        = ENV['consumer_key']
    config.consumer_secret     = ENV['consumer_secret']
    config.oauth_token        =  ENV['oauth_token']
    config.oauth_token_secret =  ENV['oauth_token_secret']
    config.auth_method        = :oauth
    end
end

def config_twitter
	Twitter::REST::Client.new do |config|
    config.consumer_key        = ENV['consumer_key']
    config.consumer_secret     = ENV['consumer_secret']
    config.access_token        = ENV['oauth_token']
    config.access_token_secret = ENV['oauth_token_secret']
    end
end