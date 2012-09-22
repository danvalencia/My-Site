require 'test_helper'

class CommentTest < ActiveSupport::TestCase
  # test "the truth" do
  #   assert true
  # end
  test "can't create comment without an author" do
  	parent_post = posts(:one)
    comment = Comment.new
    comment.body = "Great post buddy!"
    comment.parent_post = parent_post

    # Not adding a comment_author
    result_of_save = comment.save
    assert_equal false, result_of_save, "Expected not being able to save"

    comment_author = comment_authors(:one)
    comment.comment_author = comment_author

    result_of_save = comment.save
    assert result_of_save, "Expected to be able to save comment now" 
  end
end
