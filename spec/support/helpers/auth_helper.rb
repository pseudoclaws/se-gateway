# frozen_string_literal: true
module AuthHelper
  def auth_request(user)
    sign_in user
    request.headers.merge!(user.create_new_auth_token)
  end

  def http_login
    user = 'test'
    pw = 'test'
    request.env['HTTP_AUTHORIZATION'] = ActionController::HttpAuthentication::Basic.encode_credentials(
      user,
      pw
    )
  end
end
