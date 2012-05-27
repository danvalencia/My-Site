class PostsController < ApplicationController
  
  def index
    @posts = Post.find :all    
  end
  
  def show
    @post = Post.find(params[:id])
  end

  def new
    @post = Post.new
  end

  def create
  end

  def destroy
  end
end
