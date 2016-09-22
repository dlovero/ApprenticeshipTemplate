module ControllerExceptionsHandler

  EXCEPTION_MAP = {
      ActiveRecord::RecordNotFound => :not_found,
      ActiveRecord::RecordInvalid => :bad_request,
      ExpiredCartException => :unprocessable_entity,
      UnauthorizedException => :unauthorized,
      WrongAmountOfBooksException => :bad_request,
      ActionController::ParameterMissing => :bad_request,
      ArgumentError => :bad_request
  }
  EXCEPTION_MAP.default=:internal_server_error

  def self.included(a_module)
    a_module.around_filter :exception_handling
  end

  def exception_handling
    begin
      yield
    rescue Exception => error
      render json: {error: error.message}, status: EXCEPTION_MAP[error.class]
    end
  end

end