class PostsController < ApplicationController
  load_and_authorize_resource

  before_action :find_post, only: %i[show edit update destroy submit_post approve_post decline_post publish_post archive_post]

  def show; end

  def new
    @post = Post.new
  end

  def edit; end

  def create
    user = User.find(params[:user_id])
    @post = Post.create(post_params.merge(user: user))
    if @post.save
      redirect_to user_path(user), notice: 'Post created'
    else
      render :new
    end
  end

  def update
    if @post.update(post_params)
      redirect_to user_post_path(@post.user_id, @post.id)
    else
      render :edit
    end
  end

  def destroy
    @post.destroy
    redirect_to user_path(@post.user_id)
  end

  def submit_post
    @post.submit!
    redirect_to user_post_path(@post.user_id, @post.id)
  end

  def undo_submit
    @post.undo!
    redirect_to user_post_path(@post.user_id, @post.id)
  end

  def approve_post
    @post.approve!
    redirect_to admin_posts_path
  end

  def decline_post
    @post.decline!
    redirect_to admin_posts_path
  end

  def publish_post
    @post.publish!
  end

  def archive_post
    @post.archive!
  end

  private

  def find_post
    @post = Post.find(params[:id])
  end

  def post_params
    params.require(:post).permit(:title, :text, :image_url, :category_id, :user_id)
  end
end
