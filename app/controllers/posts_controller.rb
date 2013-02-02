class PostsController < ApplicationController
  before_filter :authenticate_user!, :only => [:new, :create, :destroy, :update]
  
  def index
    @posts = Post.order("created_at DESC")
  end
  
  def show
    if(params[:friendly_url])
      @post = Post.find_by_friendly_url(params[:friendly_url])
    else
      @post = Post.find(params[:id])
    end
    @comment = @post.comments.build
  end

  def edit
    @post = Post.find(params[:id])
    @comment = @post.comments.build
  end

  def new
    @post = Post.new if @post.nil?
  end

  def create
    @post = Post.new(params[:post])
    @post.author = current_user
    if @post.save
      redirect_to @post
    else
      render :action => :new
    end
  end

  def update
    @post = Post.find(params[:id])
    if @post.update_attributes(params[:post])
      redirect_to :action => :show, :id => @post.id
    else
      render :edit
    end
  end

end
