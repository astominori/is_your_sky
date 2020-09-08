class SessionsController < ApplicationController
  def create
#    user = User.find_by(email: params[:session][:email].downcase)
#    if user && user.authenticate(params[:session][:password])
#      session[:user_id] = user.id
#      redirect_to mypage_path
#    end
#      render 'home/index'
#    end
  end

  def destroy
#    session.delete(:user_id)
#    redirect_to root_path
  end
end
