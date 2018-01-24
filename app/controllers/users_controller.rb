class UsersController < ApplicationController
  before_action :set_user, except: :index

  def index
    @users = User.all
  end

  def show
    @commented_restaurants = @user.restaurants.uniq
  end

  def edit
  end

  def update
    if @user == current_user
      if @user.update(user_params)
        flash[:notice] = "User was seccessfully updated."
        redirect_to user_path(@user)
      else
        flash.now[:alert] = "User was failed to update."
        render :edit
      end
    end
  end

  private

  def set_user
    @user = User.find(params[:id])
  end

  def user_params
    params.require(:user).permit(:name, :intro, :avatar)
  end

end
