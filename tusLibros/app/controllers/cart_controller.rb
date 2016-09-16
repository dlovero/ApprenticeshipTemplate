require_relative 'application_controller'

class CartController < ApplicationController
  around_action :exception_handling

  def create
    user = User.log_in!(create_params)
    cart_session = CartSession.for!(user)
    render json: cart_session, status: :created
  end

  def add
    book = Book.find_by_isbn!(book_isbn)
    cart_session = CartSession.find_by_cart_id!(cart_id)
    cart_session.add(book, book_quantity)
    render json: :nothing, status: :ok
  end

  def show
    cart_session = CartSession.find_by_cart_id!(cart_id)
    render json: cart_session.items, status: :ok
  end

  def checkout
    cart_session = CartSession.find_by_cart_id!(cart_id)
    credit_card = CreditCard.find_or_create_by!(credit_card_params)
    sale_id=Cashier.new(MerchantProcessor.new).checkout(cart_session, credit_card)
    render json: Sale.find(sale_id), status: :ok
  end

  private
  def credit_card_params
    params.require(:credit_card).permit(:credit_card_number, :credit_card_owner, :expiration_date)
  end

  def create_params
    params.require(:login).permit(:id,:password)
  end

  def book_quantity
    params.require(:bookQuantity)
  end

  def cart_id
    params.require(:cartId)
  end

  def book_isbn
    params.require(:bookIsbn)
  end
end

