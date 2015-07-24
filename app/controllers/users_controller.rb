class UsersController < ApplicationController

  def index
    @users = User.all
  end

  def new
    @user = User.new
  end

  def create
    @user = User.new(user_params)
    if @user.save
      flash[:success] = "User successfully created"
      redirect_to users_url
    else
      render action: 'new'
    end
  end

  def update
    if @user.update(user_params)
      flash[:success] = "User successfully updated"
      redirect_to users_url
    else
      render action: 'edit'
    end
  end

  def edit
    @user = User.find(params[:id])
  end

  def destroy
    @user = User.find(params[:id])
    if @user.destroy
      flash[:success] = "User successfully deleted"
      redirect_to users_url
    else
      flash[:error] = "User unsuccessfully deleted"
      redirect_to users_url
    end
  end

  private
    def user_params
      params.require(:user).permit(:name, :password, :password_confirmation)
    end
end
