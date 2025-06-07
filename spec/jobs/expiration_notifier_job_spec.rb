# frozen_string_literal: true

require "rails_helper"

RSpec.describe ExpirationNotifierJob do
  let(:job) { described_class.new }
  let(:expiration_settings) do
    {
      expiration_notification_days: 3,
      expiration_notification_channels: ["apprise://notify"]
    }
  end
  let!(:user_with_no_coupons) { create(:user, **expiration_settings) }
  let!(:user_with_valid_coupon) { create(:user, **expiration_settings) }
  let!(:user_with_expired_and_valid_coupon) { create(:user, **expiration_settings) }

  let!(:valid_coupon_1) do
    create(:coupon, user: user_with_valid_coupon, valid_until: 3.days.from_now)
  end

  let!(:valid_coupon_2) do
    create(:coupon, user: user_with_expired_and_valid_coupon, valid_until: 3.days.from_now)
  end

  let!(:expired_coupon) do
    create(:coupon, user: user_with_expired_and_valid_coupon, valid_until: 2.days.ago)
  end

  before do
    allow(Ops::Coupon::Expiration::Notify).to receive(:new).and_call_original
    allow_any_instance_of(Ops::Coupon::Expiration::Notify).to receive(:call)
  end

  it "notifies only soon to expire coupons" do
    expect(Ops::Coupon::Expiration::Notify).to receive(:new)
      .with(coupon: valid_coupon_1).and_call_original
    expect(Ops::Coupon::Expiration::Notify).to receive(:new)
      .with(coupon: valid_coupon_2).and_call_original
    expect(Ops::Coupon::Expiration::Notify).not_to receive(:new)
      .with(coupon: expired_coupon)

    job.perform
  end
end
