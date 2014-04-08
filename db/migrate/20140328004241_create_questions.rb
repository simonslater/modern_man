class CreateQuestions < ActiveRecord::Migration
  def change
   	  create_table :questions do |t|
      t.string :interviewer
      t.string :tweet
      t.timestamps
    end

  end
end
