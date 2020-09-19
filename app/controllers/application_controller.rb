class ApplicationController < ActionController::Base
  before_action :configure_permitted_parameters, if: :devise_controller?

  protected
  # methodをオーバーライドする。
  def configure_permitted_parameters
      # account_update, sign_in, sign_up, のフィールドを再定義
    devise_parameter_sanitizer.permit(:sign_up, keys: [:username,:avatar,:bio])
    devise_parameter_sanitizer.permit(:sign_in, keys: [:username,:avatar,:bio])
    devise_parameter_sanitizer.permit(:account_update, keys: [:username,:avatar,:bio])
  end
end
