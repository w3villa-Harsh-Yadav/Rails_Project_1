class UsersController < ApplicationController
  before_action :set_user , only: [:edit, :update, :show]

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

end
