class CommentAuthor < ActiveRecord::Base
  attr_accessible :email, :name, :website
  has_many :comments
  validates_length_of   :email, minimum: 10, maximum: 50
  validates_length_of   :name, minimum: 8, maximum: 20
  validates_length_of   :website, minimum: 8, maximum: 50
  accepts_nested_attributes_for :comments
end
