class ChangePostsBodyColumnType < ActiveRecord::Migration
  def up
  	change_table :posts do |t|
  		t.change :body, :text
  	end
  end

  def down
  	change_table :posts do |t|
  		t.change :body, :string
  	end
  end
end
