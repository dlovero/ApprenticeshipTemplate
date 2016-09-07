require_relative 'application_controller'

class CartController < ApplicationController

  def list_cart
    cart = Cart.find(params[:id])
    render :template => 'cart/list_cart', :locals => { :cart => cart }
  end

end