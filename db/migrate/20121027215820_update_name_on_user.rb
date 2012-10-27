class UpdateNameOnUser < ActiveRecord::Migration
  def up
    User.find(:all) do |u|
      u.name = "Daniel Valencia"
      u.save!
    end
  end

  def down
  end
end
