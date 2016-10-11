class UserController < ApplicationController

  def create_user
    user = User.create!(username: username)
    render json: user, status: :ok
  end

  def login
    user = User.find_by!(username: username)
    render json: user, status: :ok
  end

  private

  def username
    params.require(:username)
  end

end