# frozen_string_literal: true

class Web::Movies::CommentsController < Web::Movies::ApplicationController
  def index
    @comments = resource_movie.comments
  end

  def new
    @comment = Comment.new
  end

  def edit
    @comment = Comment.find params[:id]
  end

  def create
    @movie = resource_movie
    @comment = Comment.build(permitted_comment_params)
    @comment.movie_id = @movie.id
    if @comment.save
      redirect_to movie_comments_path, notice: t('success')
    else
      flash[:alert] = t('fail')
      render :new, status: :unprocessable_entity
    end
  end

  def update
    @comment = Comment.find params[:id]

    if @comment.update(permitted_comment_params)
      redirect_to movie_comments_path, notice: t('success')
    else
      flash[:alert] = t('fail')
      render :edit, status: :unprocessable_entity
    end
  end

  def destroy
    @comment = Comment.find params[:id]

    @comment&.destroy!

    redirect_to movie_comments_path, notice: t('.success')
  end

  private

  def permitted_comment_params
    params.require(:comment).permit(:body)
  end
end
