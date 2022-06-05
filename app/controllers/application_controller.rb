class ApplicationController < ActionController::API

  def current_user
    code = request.headers["Authorization"].to_s
    if code.present?
      user = User.find_by(authentication_token: code)
    end
    user
  end
end
