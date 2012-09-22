class CommentAuthor < ActiveRecord::Base
  attr_accessible :email, :user, :website
  has_many :comments
  validates_length_of   :email, minimum: 10, maximum: 50
  validates_length_of   :user, minimum: 8, maximum: 20
  validates_length_of   :website, minimum: 8, maximum: 50
end
