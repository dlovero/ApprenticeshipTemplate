class SaleController < ApplicationController

  def list
    all_sales=Sale.where(user_id: params[:userId].to_i)
    if !all_sales.empty?
      all_sales_formated=all_sales.collect do |a_sale|
        a_sale.find_all_sales_formated(params[:userId].to_i)
      end
      return render json: {params[:userId] => all_sales_formated.flatten}, status: :ok
    end
    render json: {:error => 'Could not list'}, status: :bad_request
  end

end
