class ChangeTweetId < ActiveRecord::Migration
  def change
  	rename_column :responses, :tweet_id, :question_id
  end
end
