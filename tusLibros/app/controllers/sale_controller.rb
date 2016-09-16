class SaleController < ApplicationController

  around_action :exception_handling

  def show
    user=User.find_by!(show_param)
    all_sales=Sale.find_all_sales_formated(user)
    render json: all_sales, status: :ok
  end

  private

  def show_param
    {id: params.require(:userId).to_i}
  end

end
