class ApiController < ActionController::Base
  skip_before_action :verify_authenticity_token

  # necessary in all controllers that will respond with JSON
  respond_to :json 

  private

#   def authenticated?
# # #2
#    authenticate_or_request_with_http_basic {|username, password| User.where( email: username, id: password).present? }
#   end

  def authenticated?
    authenticate_or_request_with_http_basic('Administration') do |email, password|
      user = User.find_by_email(email)
      user.valid_password?(password)
    end
  end



  # Error responses and before_action blocking work differently with Javascript requests.
  # Rather than using before_actions to authenticate actions, we suggest using
  # "guard clauses" like `permission_denied_error unless condition`
  def permission_denied_error
    error(403, 'Permission Denied!')
  end

  def error(status, message = 'Something went wrong')
    response = {
      response_type: "ERROR",
      message: message
    }

    render json: response.to_json, status: status
  end

end