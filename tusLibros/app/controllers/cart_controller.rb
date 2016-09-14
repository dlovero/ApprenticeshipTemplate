require_relative 'application_controller'

class CartController < ApplicationController

  before_action

  def new
    user = User.find_by(id: params[:userId].to_i, password: params[:password])
    return render json: {error: "Failed to authenticate"}, status: :unauthorized if user.nil?
    cart = Cart.create(user_id: user.id)
    return render json: {error: "Could not create"}, status: :bad_request if (!cart.valid? || cart.nil?)
    return render json: {id: cart.id}, status: :created

  end

  def add
    book = Book.find_by(isbn: params[:bookIsbn])
    cart = Cart.find_by(id: params[:cartId].to_i)
    return render json: {error: "Cart not found"}, status: :not_found if cart.nil?
    return render json: {error: "Book not found"}, status: :not_found if book.nil?
    return render json: :nothing, status: :ok if cart.add(book, params[:bookQuantity].to_i)
    return render json: {error: "Could not add"}, status: :bad_request #unlikely
  end

  def list
    cart = Cart.find_by(id: params[:cartId].to_i)
    return render json: {error: "Cart not found"}, status: :not_found if cart.nil?
    list_of_items=cart.list
    return render json: {cart.id => list_of_items}, status: :ok if !list_of_items.nil?
    return render json: {error: "Could not list"}, status: :bad_request #unlikely
  end

  def checkout
    cart = Cart.find_by(id: params[:cartId].to_i)
    return render json: {error: "Cart not found"}, status: :not_found if cart.nil?
    credit_card = CreditCard.find_or_create_by(credit_card_number: params[:ccn], credit_card_owner: params[:cco], expiration_date: params[:cced])
    return render json: {error: "Bad credit card"}, status: :bad_request if (credit_card.nil? || !credit_card.valid?)
    return render json: {"TRANSACTION_ID" => Sale.find_by(cart_id: cart.id).id}, status: :ok if Cashier.new(MerchantProcessor.new).checkout(cart, credit_card)
    return render json: {error: "Could not checkout"}, status: :bad_request #unlikely
  end
end
