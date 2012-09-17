class AddEmailAndUserAndWebsiteToComments < ActiveRecord::Migration
  def change
  	add_column :comments, :email, :string
  	add_column :comments, :user, :string
  	add_column :comments, :website, :string
  end
end
