# frozen_string_literal: true

module Coupons
  class BadgesController < ApplicationController
    load_and_authorize_resource :coupon, through: :current_user, parent: true

    def destroy
      @coupon.badge.purge

      redirect_to coupon_path(@coupon)
    end
  end
end
