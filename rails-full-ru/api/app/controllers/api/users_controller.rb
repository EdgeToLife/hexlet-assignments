# frozen_string_literal: true

class Api::UsersController < Api::ApplicationController
  # BEGIN
  def show
    @user = User.find_by(id: params[:id])
    respond_with @user.as_json
  end

  def index
    @users = User.all
    respond_with @users.as_json
  end
  # END
end
