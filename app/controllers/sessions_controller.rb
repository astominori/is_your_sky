class SessionsController < ApplicationController
  def new
  end

  def create
    user = User.find_by(email: params[:session][:email].downcase)
    if user && user.authenticate(params[:session][:password])
      log_in user
      current_user
      binding.pry
      redirect_to user
    else
      flash.now[:danger] = "正しいメールアドレス/パスワードを入力してください"
      render 'home/index'
    end
  end

  def destroy
    log_out
    redirect_to root_path
  end

end
