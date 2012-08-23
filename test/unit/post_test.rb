require 'test_helper'

class PostTest < ActiveSupport::TestCase
  # test "the truth" do
  #   assert true
  # end
  test "Should render all comments in order" do
    post = posts(:one)
    assert_not_nil post

    comments = post.get_all_child_comments
    assert_equal 1, comments.size, "Expected to have 1 comment only"

    child_comment = comments[0]
    assert_not_nil child_comment

  end
end
