class UsersController < ApplicationController
  before_action :set_user , only: [:edit, :update, :show, :destroy]
  before_action :require_user, except: [ :show, :index, :new]
  before_action :require_same_user, only: [ :edit, :update, :destroy]

  def index
    @users = User.paginate(page: params[:page], per_page: 3)
  end

  def new
    @user = User.new
  end

  def show
  end

  def create
    @user = User.new(user_params)
    if @user.save
      session[:user_id] = @user.id
      flash[:notice]="Welcome to Alpha Blog #{@user.username}, you have been succesfully signed up"
      redirect_to articles_path
    else
      render :new, status: :unprocessable_entity
    end
  end

  def edit
  end

  def update
    if User.update(user_params)
      redirect_to user_path(@user), notice: "Profile updated successfully"
    else
      render :edit , status: :unprocessable_entity
    end
  end

  def destroy
    @user.destroy
    session[:user_id] = nil
    flash[:alert] = "Your account and all of your articles are deleted successfully."
    redirect_to login_path
  end

  private
  def user_params
    params.require(:user).permit(:username, :email, :password)
  end

  def set_user
    begin
      @user = User.find(params[:id])
    rescue => exception
      redirect_to root_path , notice: exception
    end
  end

  def require_same_user
    if current_user != @user
      flash[:alert] = "You are only allowed to edit your own profile."
      redirect_to articles_path
    end
  end

end
