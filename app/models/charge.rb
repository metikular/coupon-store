# frozen_string_literal: true

class Charge < ApplicationRecord
  belongs_to :gift_card

  monetize :amount_cents
end
