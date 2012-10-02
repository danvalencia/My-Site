class CommentAuthor < ActiveRecord::Base
  attr_accessible :email, :name, :website

  has_many :comments

  validates :email, :presence => true, :allow_blank => false, :uniqueness => true, :length => {:maximum => 50}
  validates :name, :allow_blank => true, :length => {:maximum => 300}
  validates :website, :allow_blank => true, :length => {:maximum => 60}

  accepts_nested_attributes_for :comments
end
