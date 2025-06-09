# frozen_string_literal: true

FactoryBot.define do
  factory :gift_card do
    user
    name { "My gift card" }
    currency { "USD" }
    balance { Money.from_amount(100, "USD") }
  end
end
