# frozen_string_literal: true

class Web::RepositoriesController < Web::ApplicationController
  def index
    @repositories = Repository.all
  end

  def new
    @repository = Repository.new
  end

  def show
    @repository = Repository.find params[:id]
  end

  def create
    # BEGIN
    repository_url = params[:repository][:link]
    @repository = Repository.create!(link: repository_url)
    RepositoryLoaderJob.perform_later(@repository)
    redirect_to repositories_path, notice: t('success')
    # END
  end

  def update
    # BEGIN
    @repository = Repository.find params[:id]
    RepositoryLoaderJob.perform_later(@repository)
    redirect_to repositories_path, notice: t('success')
    # END
  end

  def update_repos
    # BEGIN
    @repositories = Repository.all.order(created_at: :desc)
    @repositories.each do |repo|
      RepositoryLoaderJob.perform_later(repo)
    end
    redirect_to repositories_path, notice: t('success')
    # END
  end

  def destroy
    @repository = Repository.find params[:id]

    if @repository.destroy
      redirect_to repositories_path, notice: t('success')
    else
      redirect_to repositories_path, notice: t('fail')
    end
  end

  private

  def permitted_params
    params.require(:repository).permit(:link)
  end
end
