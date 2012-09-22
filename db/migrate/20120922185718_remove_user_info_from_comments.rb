class RemoveUserInfoFromComments < ActiveRecord::Migration
  
  def up
    remove_column :comments, :email
    remove_column :comments, :user
    remove_column :comments, :website
  end

  def down
    add_column :comments, :website, :string
    add_column :comments, :user, :string
    add_column :comments, :email, :string
  end
end
