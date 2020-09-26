class OmniauthCallbacksController < Devise::OmniauthCallbacksController
  def facebook
    @user = User.from_omniauth(request.env["omniauth.auth"])
    if @user.persisted?
      sign_in_and_redirect @user, event: :authentication
      set_flash_message(:notice, :success, kind: "Facebook") if is_navigational_format?
    else
      session["devise.user_attributes"] = @user.attributes
      flash[:notice] = "facebook認証が完了しました。会員登録をしてください"
      redirect_to new_user_registration_url
    end
  end

  def twitter
    @user = User.from_omniauth(request.env["omniauth.auth"])

    if @user.persisted?
      sign_in_and_redirect @user, event: :authentication
      set_flash_message(:notice, :success, kind: "Twitter") if is_navigational_format?
    else
      session["devise.user_attributes"] = @user.attributes
      flash[:notice] = "Twitter認証が完了しました。会員登録をしてください"
      redirect_to new_user_registration_url
    end
  end

  def failure
    redirect_to root_path
  end
end
