# frozen_string_literal: true

FactoryBot.define do
  factory :charge do
    gift_card

    note { "Test charge" }
    amount { Money.from_amount(5, "USD") }
  end
end
