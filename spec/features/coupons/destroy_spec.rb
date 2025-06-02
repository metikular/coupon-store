# frozen_string_literal: true

RSpec.describe "destroy coupons" do
  let(:user) { create(:user) }
  let!(:coupon) { create(:coupon, user:) }

  before do
    login_as user
  end

  it "deletes a coupon" do
    visit coupon_path(coupon, locale: :en)

    expect(page).to have_content coupon.store

    expect do
      click_on I18n.t("coupons.show.delete")
    end.to change(Coupon, :count).by(-1)

    expect(page).to have_current_path coupons_path(locale: :en)
    expect { coupon.reload }.to raise_error(ActiveRecord::RecordNotFound)
  end
end
