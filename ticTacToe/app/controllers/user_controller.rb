class UserController < ApplicationController

  def create_user
    user = User.create!(username: username)
    render json: user, status: :ok
  end

  def challenge
    user = User.find_by!(username: username)
    challenged = User.find_by!(username: challenger)
    board = Board.create!(player_x:user, player_o:challenged)
    render json: board, status: :ok
  end

  def login
    user = User.find_by!(username: username)
    render json: user, status: :ok
  end

  private

  def username
    params.require(:username)
  end

  def challenger
    params.require(:challenger)
  end

end