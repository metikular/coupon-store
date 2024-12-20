# frozen_string_literal: true

class ChargesController < ApplicationController
  load_and_authorize_resource :gift_card, through: :current_user
  load_and_authorize_resource through: :gift_card

  def index
    @charges = @gift_card.charges.order(created_at: :desc)
  end

  def new
  end

  def create
    successful = false

    @gift_card.with_lock do
      successful = @charge.save

      if successful
        @gift_card.balance += @charge.amount
        @gift_card.save!
      end
    end

    if successful
      respond_to do |format|
        format.html do
          redirect_to gift_card_charges_path(@gift_card)
        end
        format.turbo_stream do
          @charges = @gift_card.charges.order(created_at: :desc)
        end
      end
    else
      render :new, status: :unprocessable_entity
    end
  end

  def edit
  end

  def update
    successful = false

    @gift_card.with_lock do
      successful = @charge.update(charge_params)

      if successful && @charge.amount_cents_previously_changed?
        cents_change = @charge.previous_changes["amount_cents"].reduce(:-)

        @gift_card.balance -= Money.new(cents_change)
        @gift_card.save!
      end
    end

    if successful
      respond_to do |format|
        format.html do
          redirect_to gift_card_charges_path(@gift_card)
        end
        format.turbo_stream do
          @charges = @gift_card.charges.order(created_at: :desc)
          render "create"
        end
      end
    else
      render :edit, status: :unprocessable_entity
    end
  end

  def destroy
    @gift_card.with_lock do
      @charge.destroy!
      @gift_card.balance -= @charge.amount
      @gift_card.save!
    end

    respond_to do |format|
      format.html do
        redirect_to gift_card_charges_path(@gift_card)
      end
      format.turbo_stream do
        @charges = @gift_card.charges.order(created_at: :desc)
        render "create"
      end
    end
  end

  private

  def charge_params
    params
      .require(:charge)
      .permit(
        :note,
        :amount
      )
  end
end
