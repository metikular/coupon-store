# frozen_string_literal: true

RSpec.describe "create coupons" do
  let(:user) { create(:user) }

  before do
    login_as user
  end

  let(:code) { "0705632441947" }
  let(:store) { "Acme" }
  let(:description) { "20% off" }
  let(:valid_until) { 1.month.from_now.to_date.iso8601 }

  it "creates a new coupon" do
    visit coupons_path(locale: :en)

    click_on I18n.t("coupons.new.title")
    expect(page).to have_css "h1", text: I18n.t("coupons.new.title")

    fill_in Coupon.human_attribute_name(:code), with: code
    select I18n.t("enumerize.coupon.barcode_type.ean_13"), from: Coupon.human_attribute_name(:barcode_type)
    fill_in Coupon.human_attribute_name(:store), with: store
    fill_in Coupon.human_attribute_name(:description), with: description
    fill_in Coupon.human_attribute_name(:valid_until), with: valid_until

    expect do
      click_on I18n.t("helpers.submit.create", model: I18n.t("activerecord.models.coupon.one"))
    end.to change(Coupon, :count).by(1)

    expect(Coupon.last).to have_attributes(
      code:,
      barcode_type: "ean_13",
      store:,
      description:,
      valid_until: Date.parse(valid_until)
    )

    expect(page).to have_current_path coupons_path(locale: :en)
    expect(page).to have_content store
    expect(page).to have_content description
    expect(page).to have_content code
  end

  it "shows a preview with possible barcodes", :js do
    visit new_coupon_path(locale: :en)

    expect(page).to have_css "h1", text: I18n.t("coupons.new.title")
    expect(page).not_to have_css ".modal"
    expect(page).to have_select Coupon.human_attribute_name(:barcode_type), selected: I18n.t("enumerize.coupon.barcode_type.none")

    fill_in Coupon.human_attribute_name(:code), with: code
    click_on I18n.t("coupons.form.help_choose")

    expect(page).to have_css ".modal"
    find('button[data-barcode-type="ean_13"]').click
    expect(page).not_to have_css ".modal"
    expect(page).to have_select Coupon.human_attribute_name(:barcode_type), selected: I18n.t("enumerize.coupon.barcode_type.ean_13")
  end
end
