class UpdateExistingPostsWithFriendlyUrl < ActiveRecord::Migration
  def up
    Post.all.each do |p|
      if p.friendly_url.blank?
        p.friendly_url = p.title.gsub(" ", "_").downcase
        p.save
      end
    end
  end

  def down
  end
end
