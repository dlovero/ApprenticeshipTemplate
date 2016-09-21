class BookController < ApplicationController

  def index
    render json: Book.all, status: :ok
  end

end
