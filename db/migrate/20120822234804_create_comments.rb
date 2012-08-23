class CreateComments < ActiveRecord::Migration
  def change
    create_table :comments do |t|
      t.text :body
      t.integer :parent_post_id
      t.integer :parent_comment_id

      t.timestamps
    end
  end
end
