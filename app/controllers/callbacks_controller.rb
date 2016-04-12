class CallbacksController < Devise::OmniauthCallbacksController
  def facebook
    @user = User.from_omniauth(request.env["omniauth.auth"])
    sign_in_and_redirect root_path
  end

  def redirect_callbacks
    redirect_to redirect_route
  end
end
