class RenameCommentAuthorUserToName < ActiveRecord::Migration
  def up
  	rename_column :comment_authors, :user, :name
  end

  def down
  	rename_column :comment_authors, :name, :user
  end
end
