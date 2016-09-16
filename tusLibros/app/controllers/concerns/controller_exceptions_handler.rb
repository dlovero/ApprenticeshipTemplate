module ControllerExceptionsHandler

  def exception_handling
    begin
      yield
    rescue Exception => error
      set_exception_map
      render json: {error: error.message}, status: @exception_status_map[error.class].to_sym
    end
  end

  private

  def set_exception_map
    @exception_status_map = {
        ActiveRecord::RecordNotFound => "not_found",
        ExpiredCartException =>  "bad_request",
        ActiveRecord::RecordInvalid => "bad_request",
        ExpiredCartException => "unprocessable_entity",
        UnauthorizedException => "unauthorized",
        WrongAmountOfBooksException => "bad_request",
        Exception => "internal_server_error"
    }
  end
end