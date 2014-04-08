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
    config.consumer_key        = "eyH3dv5LMgUXjkqOosVMAw"
    config.consumer_secret     = "BiNvYU9CCHh9JtXasxYulXRCkxS16sj3KzrqL2UCg"
    config.access_token        = "2412955033-zt1mSoFXZuBLU9A40SIocguwnGQzcEVPAGTLyqf"
    config.access_token_secret = "qpoU9jl9NY8nqC738L7VH2guxcqlasmHjIOphwMjNuy2c"
    end
end