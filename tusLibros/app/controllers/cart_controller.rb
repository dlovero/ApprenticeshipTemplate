require_relative 'application_controller'

class CartController < ApplicationController

  def list_cart
    @message = 'Hola mundo'
    #render 'hola'
  end

end