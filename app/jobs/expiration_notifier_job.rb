# frozen_string_literal: true

class ExpirationNotifierJob < ApplicationJob
  def perform
    User.includes(:coupons).find_each do |user|
      next unless user.has_notification_settings?

      user
        .coupons
        .valid
        .expires_in(user.expiration_notification_days)
        .each do |coupon|
          Ops::Coupon::Expiration::Notify.new(coupon:).call
        end
    end
  end
end
