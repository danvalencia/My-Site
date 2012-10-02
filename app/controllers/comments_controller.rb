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
    @comment_author = CommentAuthor.find_or_create_by_email(params[:comment][:comment_author]);
    @comment = Comment.new do |c|
      c.body = params[:comment][:body]
      c.parent_post_id = params[:post_id]
      c.comment_author_id = @comment_author.id
    end

    if(@comment.save)
      logger.info "Save of comment succesfull!!"
      redirect_to @comment.parent_post
    else
      logger.info "Save of comment unsuccesfull!!"
      @post = @comment.parent_post
      render :template => "posts/show"
    end
  end

end
