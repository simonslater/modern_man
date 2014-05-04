task :add_tweets do
	#add tweets for cover
	twits = twitter_search(config_twitter, "modern", 100)
	twits.each do |q| 
	add= Tweet.new(tweet: "#{q.text}")
	add.save 
	end
	
	#add tweets for interview section 
	interview_questions = twitter_search(config_twitter, "from:#{"KimKardashian"} ?", 100)
	interview_questions.each do |q| 
	add= Question.new(interviewer: "#{q.user.name}", tweet: "#{q.text}")
  	add.save 
  	end
end

