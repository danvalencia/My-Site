class CommentAuthor < ActiveRecord::Base
  attr_accessible :email, :name, :website

  has_many :comments

  validates :email, :presence => true, :allow_blank => false, :uniqueness => true
  validates :name, :presence => true, :allow_blank => false

  accepts_nested_attributes_for :comments
end
