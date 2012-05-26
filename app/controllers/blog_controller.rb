class BlogController < ApplicationController
  def show
    @posts = Post.find :all
  end
end
