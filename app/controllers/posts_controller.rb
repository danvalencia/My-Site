class PostsController < ApplicationController
  
  def index
    @posts = Post.find :all    
  end
  
  def show
  end

  def new
  end

  def create
  end

  def destroy
  end
end
