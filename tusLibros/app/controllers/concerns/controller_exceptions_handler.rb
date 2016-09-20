module ControllerExceptionsHandler

  EXCEPTION_MAP = {
      ActiveRecord::RecordNotFound => "not_found",
      ExpiredCartException =>  "bad_request",
      ActiveRecord::RecordInvalid => "bad_request",
      ExpiredCartException => "unprocessable_entity",
      UnauthorizedException => "unauthorized",
      WrongAmountOfBooksException => "bad_request",
      Exception => "internal_server_error",
      ActionController::ParameterMissing => "bad_request"
  }

  def self.included(a_module)
    a_module.around_filter :exception_handling
  end

  def exception_handling
    begin
      yield
    rescue Exception => error
      render json: {error: error.message}, status: EXCEPTION_MAP[error.class].to_sym
    end
  end

end