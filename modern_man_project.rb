require "sinatra"
require 'dotenv' if development?
Dotenv.load".env" if development?
require "sinatra/activerecord"
require "shotgun"
require "nokogiri"
require "mechanize"
require "engtagger"
require "open-uri"
require "oauth"
require "json"
require "twitter"
require "tweetstream"
require "imgkit"
require "tempfile"
require "./environments"
Dir[Dir.pwd + "/helpers/*.rb"].each {|file| require file}
require './models/models.rb'
enable :sessions

get '/' do
	@name = 'cover'
	@background_image = grab_image("http://theiaoh.com/sexy-animated-gifs-gallery/")
	@cover_image = grab_image(hot_trends[rand(hot_trends.size-1)]) 
	@title = "Modern Man Manual" * 45
	@links = page_sections

	#---below: add some new tweets to tweet database
	@client = config_twitter
	@twit_questions = twitter_search(@client, "modern", 100)
	
	@twit_questions.each do |q| 
		add= Tweet.new(tweet: "#{q.text}")
  		add.save 
  	end

	#----get tweets
	@tweets = Tweet.all.order(id: :desc)

  	erb :cover
end

get '/two' do
	@name = 'Modern Thoughts'
	@content = letter_to_editor(letter_to_editor(grab_text_random(),grab_text_random()), letter_to_editor(grab_text_random(),grab_text_random()))
	@editor_image = grab_image("portrait+of+a+moron")
	@links = page_sections
	@source = url_tracker
	
	erb :from_editor
end

get '/three' do
	@name = 'art'
	@links = page_sections
	@source = url_tracker
	@mask = splice_svg("public/masks/rileyguston.svg", "public/masks/step2.svg")
	@background_image = grab_image("https://www.moma.org/collection/browse_results.php?criteria=O%3ADE%3AI%3A5%7CG%3AHI%3AE%3A1&template_id=6&sort_order=2&results_per_page=160&page_number=1&UC=")
	@background_image2 = grab_image(hot_trends[rand(hot_trends.size-1)])

	erb :art
end

get '/four' do
	@name = 'poetry'
	@links = page_sections
	@source = url_tracker
	@content = poetry(grab_text("http://www.poemhunter.com/poem/the-road-not-taken/", true, 'div[class^="KonaBody"]'),
		 			  grab_text("http://theglobalherald.com/transcript-of-charlie-sheen-meltdown-on-alex-jones-radio-show/12032/"))
	@author = "Percy Napoli"
	
	erb :poetry
end

get '/five' do
	@name = 'sound' 
	@links = page_sections
	@source = url_tracker
	@content = "#{grab_text_random().gsub(/\s+/, ' ')[0..rand(800)]}"

	erb :sound
end

get '/six' do
	@source = url_tracker
	@links = page_sections
	@name = 'interview'
	@client = config_twitter
	@interviewer ="KimKardashian"
	@twit_questions = twitter_search(@client, "from:#{@interviewer} ?", 20)
	@questions = Question.all

	#add questions to database
	@twit_questions.each do |q| 
		 add= Question.new(interviewer: "#{q.user.name}", tweet: "#{q.text}")
		# Save it to the database
  		 add.save 
  	end

	erb :interview
end

post '/post_six' do	
    #update database with interview responses
	question = Question.find(params[:question_id])
	response = Response.new(response: params[:response], question_id: params[:question_id], name: params[:name].capitalize)
	response.question_id = question
	response.save
	
	#configure twitter
	client = config_twitter
	client.update("@#{question.interviewer.gsub(" ","")} Modern Man Manual reader #{response.name} says #{response.response}")
	#redirect back to interview section
	redirect '/six'
end

get '/eight' do
	@source = url_tracker
	@name = 'sex'
	@content = sex("http://newyork.craigslist.org/cas/")

	erb :sex
end

