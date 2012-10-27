class UpdatePostsWithUser < ActiveRecord::Migration
  def up
    me = User.find :first
    posts = Post.find :all
    posts.each do |p|
      p.author = me
      p.save!
    end
  end

  def down
  end
end
