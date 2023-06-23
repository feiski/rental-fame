class UsersController < ApplicationController
  def edit
    @user = current_user
  end

  def update
    @user = current_user
    if @user.update(user_params)
      redirect_to profil_path(@user)
    else
      render :update, status: :unprocessable_entity
    end
  end
end

private

def user_params
  params.require(:user).permit(:description, :photo)
end
