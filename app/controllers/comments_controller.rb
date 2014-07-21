class CommentsController < ApplicationController
  before_filter :get_post
  
  def index
    @comments = @post.comments.all
  end

  def show
    @comment = @post.comments.find(params[:id])
  end

  def new
    @comment = @post.comments.build
  end

  def edit
    @comment = @post.comments.find(params[:id])
  end

  def create
    @comment = @post.comments.build(params[:comment])

    if @comment.save
      redirect_to([@post, @comment], :notice => 'Comment was successfully created.')
    else
      render :action => "new"
    end
  end

  def update
    @comment = @post.comments.find(params[:id])

    if @comment.update_attributes(params[:comment])
      redirect_to([@post, @comment], :notice => 'Comment was successfully updated.')
    else
      render :action => "edit"
    end
  end

  def destroy
    @comment = @post.comments.find(params[:id])
    @comment.destroy

    redirect_to(post_comments_url)
  end
  
  protected
  
  def get_post
    @post = Post.find_by_id(params[:post_id])
    redirect_to root_path unless @post
  end
end
