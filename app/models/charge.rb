# frozen_string_literal: true

class Charge < ApplicationRecord
  belongs_to :gift_card

  monetize :amount_cents

  after_save :adjust_balance
  after_destroy :undo_charge

  private

  def adjust_balance
    cents_difference = previous_changes.dig(:amount_cents)
    return if cents_difference.blank?

    cents_difference = cents_difference.reduce(&:-)
    difference = Money.new(cents_difference, gift_card.currency)

    gift_card.update!(balance: gift_card.balance + difference)
  end

  def undo_charge
    gift_card.update!(balance: gift_card.balance - amount * -1)
  end
end
