class SaleController < ApplicationController

  include ControllerExceptionsHandler
  around_action :exception_handling


  def show
    user=User.find_by!(id: params[:userId].to_i)
    all_sales=Sale.find_all_sales_formated(user)
    render json: all_sales, status: :ok
  end

end
