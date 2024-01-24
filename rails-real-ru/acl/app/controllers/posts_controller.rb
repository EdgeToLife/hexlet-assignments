# frozen_string_literal: true

class PostsController < ApplicationController
  after_action :verify_authorized, except: %i[index show]

  # BEGIN
  def index
    @posts = Post.all
  end

  def show
    @post = Post.find(params[:id])
  end

  def new
    @post = Post.new
    authorize @post, :new?
  end

  def edit
    @post = Post.find(params[:id])
    authorize @post, :edit?
  end

  def create
    @post = Post.new(post_params)
    authorize @post, :create?
    @post.author_id = current_user.id

    if @post.save
      redirect_to @post
    else
      render 'new'
    end
  end

  def update
    @post = Post.find(params[:id])
    authorize @post, :update?

    if @post.update(post_params)
      redirect_to @post
    else
      render 'edit'
    end
  end

  def destroy
    @post = Post.find(params[:id])
    authorize @post, :destroy?
    @post.destroy

    redirect_to posts_path
  end

  private

  def post_params
    params.require(:post).permit(:title, :body, :author)
  end
  # END
end
