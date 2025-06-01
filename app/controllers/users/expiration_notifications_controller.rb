# frozen_string_literal: true

module Users
  class ExpirationNotificationsController < ApplicationController
    before_action :set_user
    authorize_resource :current_user
    authorize_resource class: false

    def edit
    end

    def update
      if @user.update(expiration_notification_params)
        redirect_to user_path
      else
        render :edit, status: :unprocessable_entity
      end
    end

    private

    def set_user
      @user = current_user
    end

    def expiration_notification_params
      params.require(:user).permit(
        :expiration_notification_days,
        :expiration_notification_title,
        :expiration_notification_body,
        expiration_notification_channels: []
      )
    end
  end
end
