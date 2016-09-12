require_relative 'application_controller'

class CartController < ApplicationController


  def new
    user = User.find_by(id: params[:userId], password: params[:password])
    cart = Cart.create(user_id: user.id) unless user.nil?
    return render json: cart.as_json(only: [:id]), status: :created if !cart.nil? && cart.valid?
    render json: {error: "Could not create"}, status: :bad_request

  end


  def add
    book = Book.find_by(isbn: params[:bookIsbn], price: params[:price])
    cart = Cart.find_by(params[:cartId])
    if (!book.nil? && !cart.nil?) && (book.valid? && cart.valid?)
      return render json: :nothing, status: :success if cart.add(book, params[:bookQuantity])
    end
    render json: {error: "Could not add"}, status: :bad_request
  end
end
=begin

  def list
    cart = Cart.find(params[:id])
  end

  def new
    user = session[:username]
    cart = Cart.create(user_id: user)
    if cart.valid?
      render :template => 'home/home', locals: {option: 'cart_created'}
    else
    end
  end


  def add_book

  end
=end

