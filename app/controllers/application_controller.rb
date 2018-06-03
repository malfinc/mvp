class ApplicationController < ActionController::API
  rescue_from StandardError, with: :generic_error_handling

  private def generic_error_handling(exception)
    RequestErrorHandlingOperation.(controller: self, exception: exception)
  end
end
