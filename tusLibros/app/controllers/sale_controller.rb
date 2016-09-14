class SaleController < ApplicationController

  include ControllerExceptionsHandler
  around_action :exception_handling


  def show
    all_sales_formated = []
    user=User.find_by!(id: params[:userId].to_i)
    all_sales=Sale.where(user: user)
    all_sales.each do |a_sale|
      a_sale.find_all_sales_formated(all_sales_formated)
    end
    render json: all_sales_formated, status: :ok
  end

end
