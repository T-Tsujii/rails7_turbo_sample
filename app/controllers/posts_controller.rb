class PostsController < ApplicationController
  before_action :set_post, only: %i[show edit update destroy]
  before_action :redirect_index, only: [:new, :edit]

  def index
    @posts = Post.order(created_at: :asc)
  end

  def new
  end

  def edit; end

  def create
    @post = Post.new(post_params)

    if @post.save
      # redirect_to posts_url, notice: "Post was successfully created."
    else
      render :new, status: :unprocessable_entity
    end
  end

  def update
    if @post.update(post_params)
    else
      render :edit, status: :unprocessable_entity
    end
  end

  def destroy
    @post.destroy
    render turbo_stream: turbo_stream.remove(@post)
  end

  private

  def set_post
    @post = Post.find(params[:id])
  end

  def post_params
    params.require(:post).permit(:title, :body)
  end

  def redirect_index
    redirect_to posts_url unless turbo_frame_request?
  end
end
