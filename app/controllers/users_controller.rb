class UsersController < ApplicationController
  before_action :authenticate_user, {only: [:edit, :update]}

  def new
    @user = User.new(flash[:user])
  end

  def create
    @user = User.new(user_params)

    if @user.save
      log_in @user
      current_user
      flash[:notice] = "会員登録が完了しました"
      redirect_to @user
    else
      redirect_back fallback_location: root_path, flash: {
        user: @user,
        error_messages: @user.errors.full_messages
      }
    end
  end

  def show
    @user = User.find(params[:id])
    @posts = @user.posts.all
  end

  def edit
    @user = User.find(params[:id])
  end

  def update
    @user = User.find(params[:id])
    if @user.update(user_params)
      flash[:notice] = "更新しました"
      redirect_to @user
    else
      render 'edit'
    end
  end

  private
    def user_params
      params.require(:user).permit(:name,:email,
                            :password,:password_confirmation,:bio,:avatar)
    end

    def authenticate_user
      current_user
      if @current_user == nil
        redirect_to("/login")
      end
    end
end
