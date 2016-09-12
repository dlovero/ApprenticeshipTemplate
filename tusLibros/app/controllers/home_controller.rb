class HomeController < ApplicationController

  def home
    render template: 'home/home', locals:{option: 'default'}
  end

  def new
    render template: 'home/home', locals:{option:'new_cart'}
  end


end
