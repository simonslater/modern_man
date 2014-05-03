task :nuke_tweets do
	Tweet.destroy_all(["created_at < ?", 5.days.ago])
end