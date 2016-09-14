class SaleController < ApplicationController

  def show
    all_sales_formated = Hash.new
    all_sales=Sale.where(user_id: params[:userId].to_i)
    if !all_sales.empty?
      all_sales.each do |a_sale|
        a_sale.find_all_sales_formated(all_sales_formated)
      end
      return render json: all_sales_formated, status: :ok
    end
    render json: {:error => 'Could not list'}, status: :bad_request
  end

end
