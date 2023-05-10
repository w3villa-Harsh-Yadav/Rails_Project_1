class SessionsController < ApplicationController
  def new
  end

  def login
    user = User.find_by(email: params[:session][:email].downcase)
    if user && user.authenticate(params[:session][:password])
      session[:user_id] = user.id
      flash[:notice] = "Logged in Successfully"
      redirect_to user_path(user)
    else
      flash.now[:notice] = "There was something wrong with your login details"
      render :new, status: :unprocessable_entity
    end
  end

  def logout
    if(session[:user_id])
      session[:user_id] = nil
      flash[:notice] = "You have been logged out"
      redirect_to root_path
    else
      flash[:notice] = "You should first login"
      redirect_to root_path
    end
  end

  private

  def user_params
    params.require(:user).permit(:email,:password)
  end
end
