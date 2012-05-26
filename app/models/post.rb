class Post < ActiveRecord::Base
  attr_accessible :body, :excerpt, :title
end
