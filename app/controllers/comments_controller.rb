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
    @comment = Comment.new(params[:comment])
    @comment.parent_post_id = params[:post_id]
    if(@comment.save)
      redirect_to @comment.parent_post
    else
      redirect_to @comment.parent_post
    end
  end

end
