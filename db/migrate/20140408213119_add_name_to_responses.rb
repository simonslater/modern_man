class AddNameToResponses2 < ActiveRecord::Migration
  def change
  	add_column :responses, :name, :string
  end
end
