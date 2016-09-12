class UserController < ApplicationController


  def index
    render template: 'user/index', locals: {:my_error => nil}
  end

  def login
    if params[:username] == 'a' && (params[:password] == 'a')
      session[:username] = params[:username]
      render template: 'home/home', locals: {option: 'default'}
    else
      render template: 'user/index', locals: {my_error: 'user'}
    end
  end

end
