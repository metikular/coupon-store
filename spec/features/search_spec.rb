# frozen_string_literal: true

require "rails_helper"

RSpec.describe "search" do
  let(:user) { create(:user) }
  let!(:coupon) { create(:coupon, user:, store: "Acme Coupon", code: "COUPON123") }
  let!(:loyalty_card) { create(:loyalty_card, user:, store: "Acme Loyalty", code: "LOYAL123") }
  let!(:gift_card) { create(:gift_card, user:, name: "Acme Gift Card") }

  before do
    login_as user
  end

  it "finds a coupon by store" do
    visit root_path(locale: :en)

    fill_in "q", with: "Acme Coupon"
    click_on I18n.t("application.search.search")

    expect(page).to have_content coupon.store
    expect(page).to have_content coupon.code
    expect(page).not_to have_content loyalty_card.store
    expect(page).not_to have_content gift_card.name
  end

  it "finds a coupon irrelevant of the case" do
    visit root_path(locale: :en)

    fill_in "q", with: "acme coupon"
    click_on I18n.t("application.search.search")

    expect(page).to have_content coupon.store
    expect(page).to have_content coupon.code
    expect(page).not_to have_content loyalty_card.store
    expect(page).not_to have_content gift_card.name
  end

  it "finds a loyalty card by code" do
    visit root_path(locale: :en)

    fill_in "q", with: "LOYAL123"
    click_on I18n.t("application.search.search")

    expect(page).to have_content loyalty_card.store
    expect(page).to have_content loyalty_card.code
    expect(page).not_to have_content coupon.store
    expect(page).not_to have_content gift_card.name
  end

  it "finds a gift card by name" do
    visit root_path(locale: :en)

    fill_in "q", with: gift_card.name
    click_on I18n.t("application.search.search")

    expect(page).not_to have_content loyalty_card.store
    expect(page).not_to have_content coupon.store
    expect(page).to have_content gift_card.name
  end
end
