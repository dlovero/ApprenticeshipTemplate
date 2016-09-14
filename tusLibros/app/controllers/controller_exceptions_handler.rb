module ControllerExceptionsHandler

  def exception_handling
    begin
      yield
    rescue ActiveRecord::RecordNotFound => error
      render json: {"error" => error.message}, status: :not_found
    rescue ActiveRecord::RecordInvalid => error
      render json: {"error" => error.message}, status: :bad_request
    rescue ExpiredCartException => error
      render json: {"error" => error.message}, status: :unprocessable_entity
    rescue Exception => error
      render json: {"error" => error.message}, status: :internal_server_error
    end
  end
end