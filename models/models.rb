class Question < ActiveRecord::Base
	has_many :responses
	validates_uniqueness_of :tweet
end

class Response < ActiveRecord::Base
	belongs_to :question
end

class Tweet < ActiveRecord::Base
	validates_uniqueness_of :tweet
end