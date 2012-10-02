class CreateCommentAuthors < ActiveRecord::Migration
  def change
    create_table :comment_authors do |t|
      t.string :email, :null => false
      t.string :name, :null => false
      t.string :website

      t.timestamps
    end
  end
end
