require_relative 'application_controller'

class CartController < ApplicationController
  include ControllerExceptionsHandler
  around_action :exception_handling

  def create
    user = User.find_by!(id: params[:userId].to_i, password: params[:password])
    cart_session = CartSession.for!(user)
    return render json: {id: cart_session.cart_id}, status: :created
  end

  def add
    book = Book.find_by!(isbn: params[:bookIsbn])
    cart_session = CartSession.find_by!(id: params[:cartId].to_i)
    cart_session.add(book, params[:bookQuantity].to_i)
    render json: :nothing, status: :ok
  end

  def show
    cart_session = CartSession.find_by!(id: params[:cartId].to_i)
    list_of_items=cart_session.list
    render json: list_of_items, status: :ok

  end

  def checkout
    cart_session = CartSession.find_by!(id: params[:cartId].to_i)
    credit_card = CreditCard.find_or_create_by!(credit_card_number: params[:ccn], credit_card_owner: params[:cco], expiration_date: params[:cced])
    Cashier.new(MerchantProcessor.new).checkout(cart_session, credit_card)
    render json: {"TRANSACTION_ID" => Sale.find_by(user: cart_session.user).id}, status: :ok
  end


end
