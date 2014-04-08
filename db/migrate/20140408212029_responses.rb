class Responses < ActiveRecord::Migration
    def change
   	  create_table :responses do |t|
      t.string :response
      t.string :question_id
      t.string :name
      t.timestamps
    end
  end
end

