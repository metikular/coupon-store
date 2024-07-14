# frozen_string_literal: true

FactoryBot.define do
  factory :coupon do
    user

    store { Faker::Commerce.vendor }
    code { Faker::Barcode.ean }
    description { Faker::Commerce.product_name }
    valid_until { 5.days.from_now }
    barcode_type { :ean_8 }
    used { false }
  end
end
