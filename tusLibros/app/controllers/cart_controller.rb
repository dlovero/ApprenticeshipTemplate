require_relative 'application_controller'

class CartController < ApplicationController


#  before_action :assert_active_cart, only: [:add, :list, :checkout]
  def create
    user = User.find_by(id: params[:userId].to_i, password: params[:password])
    return render json: {error: "Failed to authenticate"}, status: :unauthorized if user.nil?
    cart_session = CartSession.for!(user)
    return render json: {error: "Could not create"}, status: :bad_request if (!cart_session.valid? || cart_session.nil?)
    return render json: {id: cart_session.cart_id}, status: :created

  end

  def add
    book = Book.find_by(isbn: params[:bookIsbn])
    cart_session = CartSession.find_by(id: params[:cartId].to_i)
    return render json: {error: "Cart not found"}, status: :not_found if cart_session.nil?
    return render json: {error: "Book not found"}, status: :not_found if book.nil?
    return render json: :nothing, status: :ok if cart_session.add(book, params[:bookQuantity].to_i)
    return render json: {error: "Could not add"}, status: :bad_request #unlikely
  end

  def show
    cart_session = CartSession.find_by(id: params[:cartId].to_i)
    return render json: {error: "Cart not found"}, status: :not_found if cart_session.nil?
    list_of_items=cart_session.list
    return render json: {cart_session.cart_id => list_of_items}, status: :ok if !list_of_items.nil?
    return render json: {error: "Could not list"}, status: :bad_request #unlikely
  end

  def checkout
    cart_session = CartSession.find_by(id: params[:cartId].to_i)
    return render json: {error: "Cart not found"}, status: :not_found if cart_session.nil?
    credit_card = CreditCard.find_or_create_by(credit_card_number: params[:ccn], credit_card_owner: params[:cco], expiration_date: params[:cced])
    return render json: {error: "Bad credit card"}, status: :bad_request if (credit_card.nil? || !credit_card.valid?)
    return render json: {"TRANSACTION_ID" => Sale.find_by(user: cart_session.user).id}, status: :ok if Cashier.new(MerchantProcessor.new).checkout(cart_session, credit_card)
    return render json: {error: "Could not checkout"}, status: :bad_request #unlikely
  end


end
