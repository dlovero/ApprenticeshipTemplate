require_relative 'application_controller'

class CartController < ApplicationController

  def new
    user = User.find_by(id: params[:userId].to_i, password: params[:password])
    cart = Cart.create(user_id: user.id) unless user.nil?
    return render json: {id: cart.id}, status: :created if !cart.nil? && cart.valid?
    render json: {error: "Could not create"}, status: :bad_request
  end

  def add
    book = Book.find_by(isbn: params[:bookIsbn])
    cart = find_a_cart_by_his_id
    if (!book.nil? && !cart.nil?)
      return render json: :nothing, status: :ok if cart.add(book, params[:bookQuantity].to_i)
    end
    render json: {error: "Could not add"}, status: :bad_request
  end

  def list
    cart = find_a_cart_by_his_id
    return render json: {cart.id => cart.list}, status: :ok if !cart.nil?
    render json: {error: "Could not list"}, status: :bad_request
  end


  def checkout
    cart = find_a_cart_by_his_id
    credit_card = CreditCard.find_or_create_by(credit_card_number: params[:ccn])
    if (!cart.nil?)&&(!credit_card.nil? && credit_card.valid?)
      return render json: {"TRANSACTION_ID" => Sale.find_by(cart_id: cart.id).id}, status: :ok if Cashier.new(MerchantProcessor.new).checkout(cart, credit_card)
    end
    render json: {error: "Could not checkout"}, status: :bad_request
  end

private

  def find_a_cart_by_his_id
    cart = Cart.find_by(id: params[:cartId].to_i)
  end

end
