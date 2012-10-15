class PostsController < ApplicationController
  before_filter :authenticate_user!, :only => [:new, :create, :destroy, :update]
  
  def index
    @posts = Post.all    
  end
  
  def show
    @post = Post.find(params[:id])
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
