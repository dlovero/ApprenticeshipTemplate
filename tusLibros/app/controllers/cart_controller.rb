require_relative 'application_controller'

class CartController < ApplicationController

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


end