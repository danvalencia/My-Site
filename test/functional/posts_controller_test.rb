require 'test_helper'

class PostsControllerTest < ActionController::TestCase
  include Devise::TestHelpers

  test "should get index" do
    get :index
    assert_response :success
  end

  test "should get show" do
    get :show, {:id => Post.first.id}
    assert_response :success
  end

  test "should get new" do
    sign_in users(:admin)
    get :new
    assert_response :success
  end

  test "should get create" do
    sign_in users(:admin)
    assert_difference('Post.count') do
      post :create, :post => {:title => "My Post", :excerpt => "Some summary", :body => "Some very interesting post, cool."}
    end
    assert_redirected_to post_path(assigns(:post))
  end

  # test "should get destroy" do
  #   post :destroy
  #   assert_response :success
  # end

end
