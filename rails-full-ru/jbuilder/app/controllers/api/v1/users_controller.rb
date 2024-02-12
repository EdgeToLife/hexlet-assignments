# frozen_string_literal: true

class Api::V1::UsersController < Api::ApplicationController
  # BEGIN
  respond_to :json

  def show
    @user = User.includes(:posts).find_by(id: params[:id])
    respond_with @user.as_json
  end

  def index
    @users = User.includes(:posts).all
    respond_with @users.as_json
  end
  # END
end
