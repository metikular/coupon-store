# frozen_string_literal: true

class UsersController < ApplicationController
  before_action :set_user
  authorize_resource

  def show
  end

  def edit
  end

  def update
    if @user.update(user_params)
      redirect_to user_path
    else
      render :edit
    end
  end

  def destroy
    @user.destroy!

    sign_out @user

    redirect_to "/"
  end

  private

  def set_user
    @user = current_user
  end

  def user_params
    params.require(:user).permit(:email)
  end
end
