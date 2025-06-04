# frozen_string_literal: true

FactoryBot.define do
  factory :loyalty_card do
    user

    store { Faker::Commerce.vendor }
    code { Faker::Barcode.ean }
    barcode_type { :ean_8 }
  end
end
