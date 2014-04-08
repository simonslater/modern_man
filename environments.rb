configure :development do
	set :database, "sqlite3:///modern_man.db"
	set :show_exceptions, true 
end

configure :production do
	db = URI.parse(ENV['DATABASE_URL'] || 'postgres:///localhost/mydb')

	ActiveRecord::Base.establish_connection(
		:adapter => db.scheme == 'postgres' ? 'postgresql' : db.scheme,
		:host => db.host,
		:username => db.user,
		:password => db.password,
		:database => db.path[1..-1],
		:encoding => 'utf8'
	)
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