# frozen_string_literal: true

RSpec.describe "update coupons" do
  let(:user) { create(:user) }
  let!(:coupon) { create(:coupon, user:) }

  before do
    login_as user
  end

  let(:new_store) { "Acme" }

  it "updates a coupon" do
    expect(coupon.store).not_to eq new_store

    visit coupons_path(locale: :en)

    expect(page).to have_content coupon.store

    find("a[data-id=\"#{coupon.id}\"]").click
    click_on I18n.t("coupons.show.edit")

    fill_in Coupon.human_attribute_name(:store), with: new_store
    click_on I18n.t("helpers.submit.update", model: I18n.t("activerecord.models.coupon.one"))

    expect(page).to have_current_path coupon_path(coupon, locale: :en)
    expect(coupon.reload.store).to eq new_store
  end

  it "shows errors when validations fail" do
    visit coupon_path(coupon, locale: :en)

    click_on I18n.t("coupons.show.edit")

    fill_in Coupon.human_attribute_name(:code), with: ""
    click_on I18n.t("helpers.submit.update", model: I18n.t("activerecord.models.coupon.one"))

    expect(page).to have_content I18n.t("errors.messages.blank")
  end
end
