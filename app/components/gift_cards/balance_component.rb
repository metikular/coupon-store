# frozen_string_literal: true

class GiftCards::BalanceComponent < ViewComponent::Base
  def initialize(gift_card:)
    @gift_card = gift_card
  end

  def balance
    @gift_card.balance
  end

  def warning_class
    if balance > 0
      ""
    else
      "text-danger"
    end
  end
end
