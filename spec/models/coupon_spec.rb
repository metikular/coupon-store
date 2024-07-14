# frozen_string_literal: true

RSpec.describe Coupon do
  describe ".expires_in" do
    let!(:expires_in_6_days) { create(:coupon, valid_until: 6.days.from_now) }
    let!(:expires_in_5_days) { create(:coupon, valid_until: 5.days.from_now) }
    let!(:expires_in_4_days) { create(:coupon, valid_until: 4.days.from_now) }
    let!(:expired_in_past) { create(:coupon, valid_until: 2.days.ago) }

    it "filters coupons correctly" do
      expect(described_class.expires_in(2)).to be_empty
      expect(described_class.expires_in(5)).to match_array [expires_in_5_days]
      expect(described_class.expires_in(8)).to be_empty
    end
  end
end
