# frozen_string_literal: true

class Web::Movies::ReviewsController <  Web::Movies::ApplicationController
  def index
    @reviews = resource_movie.reviews
  end

  def show
    @review = Review.find params[:id]
  end

  def new
    @review = Review.new
  end

  def edit
    @review = Review.find params[:id]
  end

  def create
    @movie = resource_movie
    @review = Review.new(permitted_review_params)
    @review.movie_id = @movie.id

    if @review.save
      redirect_to movie_reviews_path, notice: t('success')
    else
      flash[:alert] = t('fail')
      render :new, status: :unprocessable_entity
    end
  end

  def update
    @review = Review.find params[:id]

    if @review.update(permitted_review_params)
      redirect_to movie_reviews_path, notice: t('success')
    else
      flash[:alert] = t('fail')
      render :edit, status: :unprocessable_entity
    end
  end

  def destroy
    @review = Review.find params[:id]

    @review&.destroy!

    redirect_to movie_reviews_path, notice: t('.success')
  end

  private

  def permitted_review_params
    params.require(:review).permit(:body)
  end
end
