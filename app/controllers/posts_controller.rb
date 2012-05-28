class PostsController < ApplicationController
  
  def index
    @posts = Post.all    
  end
  
  def show
    @post = Post.find(params[:id])
  end

  def new
    @post = Post.new if @post.nil?
  end

  def create
    @post = Post.new(params[:post])
    if(@post.save)
      redirect_to @post
    else
      render :action => :new
    end
  end

  def destroy
  end
end
