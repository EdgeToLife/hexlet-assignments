# frozen_string_literal: true

class Api::V2::UsersController < Api::ApplicationController
  # BEGIN
  respond_to :json

  def show
    @user = User.includes(:posts).find_by(id: params[:id])
    render json: @user, serializer: UserSerializer
  end

  def index
    @users = User.includes(:posts).all
    render json: @users, each_serializer: UserSerializer
  end
  # END
end
