class SessionsController < ApplicationController

  def new
    @user = User.new
  end

  def create
    @user = User.find_by_email params[:user][:email] # || User.new
    if @user && @user.authenticate(params[:user][:password])
      session[:user_id] = @user.id
      redirect_to root_path, notice: "Logged in!"
    else
      @user = User.new
      flash[:alert] = "Wrong email or password"
      render :new
    end
  end
  def destroy
    session[:user_id] = nil
    redirect_to root_path, notice: "Logged out!"
  end
end
