# frozen_string_literal: true

class CouponsController < ApplicationController
  load_and_authorize_resource through: :current_user

  has_scope :valid, type: :boolean, default: true
  has_scope :used, type: :boolean
  has_scope :expired, type: :boolean

  def index
    @coupons = apply_scopes(@coupons).sorted_by_store
  end

  def show
  end

  def new
  end

  def create
    @preview = params[:commit] == "preview"

    if !@preview && @coupon.save
      redirect_to coupons_path
    else
      render :new
    end
  end

  def edit
  end

  def update
    @preview = params[:commit] == "preview"

    if !@preview && @coupon.update(coupon_params)
      redirect_to @coupon
    else
      render :edit
    end
  end

  def destroy
    @coupon.destroy!

    redirect_to coupons_path
  end

  def body_classes
    case params[:action]
    when "index"
      ""
    else
      "p-6"
    end
  end

  private

  def coupon_params
    params
      .require(:coupon)
      .permit(
        :code,
        :barcode_type,
        :store,
        :description,
        :valid_until,
        :used
      )
  end
end
