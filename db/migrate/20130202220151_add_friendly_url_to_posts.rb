class AddFriendlyUrlToPosts < ActiveRecord::Migration
  def change
    add_column :posts, :friendly_url, :string
  end
end
