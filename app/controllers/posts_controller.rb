class PostsController < ApplicationController
  def show
    @post = Post.find(params[:id])
  end

  def destroy
    @post.destroy
    redirect_to :root
  end
end
