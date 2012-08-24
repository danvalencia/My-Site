class CommentsController < ApplicationController
  #before_filter :authenticate_user!, :only => [:new, :create, :destroy]
  
  def new

  end

  def show
    post_params = params[:post_id]
    comments_params = params[:id]
    render :inline => "Params: #{post_params},  #{comments_params}"
  end

  def create
    post_id = params[:post_id]
    comment = params[:comment]
    
    # @post = Post.new(params[:post])
    # if(@post.save)
    #   redirect_to @post
    # else
    #   render :action => :new
    # end
  end

end
