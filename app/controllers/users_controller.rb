class UsersController < ApplicationController

  def new
    @user = User.new
    #render nothing: true
  end

  def create
    @user = User.new permitted_params
    if @user.save
      session[:user_id] = @user.id
      redirect_to root_path
    else
      flash[:notice] = error_messages
      render :new
    end
  end

  private

  def permitted_params
    params.require(:user).permit(:first_name, :last_name, :email, :password, :password_confirmation)
  end

  def error_messages
    @user.errors.full_messages.join("; ")
  end

end
