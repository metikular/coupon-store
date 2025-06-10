# frozen_string_literal: true

class BalancesController < ApplicationController
  load_and_authorize_resource :gift_card, through: :current_user

  def edit
  end

  def update
    @gift_card.with_lock do
      new_balance = Money.from_amount(params.dig(:gift_card, :balance).to_f, @gift_card.currency)
      difference = @gift_card.balance - new_balance

      @gift_card.charges.create!(
        note: I18n.t("charge.note.setting_balance"),
        amount: difference
      )
    end

    redirect_to @gift_card
  end
end
