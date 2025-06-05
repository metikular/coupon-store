# frozen_string_literal: true

require "rails_helper"

RSpec.describe "manages loyalty cards" do
  let(:user) { create(:user) }
  let(:loyalty_card) { create(:loyalty_card, user:, store: "Old Store", code: "111", barcode_type: "qr_code") }

  before do
    login_as user
  end

  it "creates a loyalty card" do
    visit loyalty_cards_path(locale: :en)

    click_on I18n.t("loyalty_cards.new.title")
    fill_in LoyaltyCard.human_attribute_name(:store), with: "Test Store"
    fill_in LoyaltyCard.human_attribute_name(:code), with: "123456"
    select I18n.t("enumerize.loyalty_card.barcode_type.ean_13"), from: LoyaltyCard.human_attribute_name(:barcode_type)

    expect do
      click_on I18n.t("helpers.submit.create", model: I18n.t("activerecord.models.loyalty_card.one"))
    end.to change(LoyaltyCard, :count).by(1)

    expect(page).to have_content("Test Store")
    expect(page).to have_content("123456")

    expect(LoyaltyCard.last).to have_attributes(
      user:,
      store: "Test Store",
      code: "123456",
      barcode_type: "ean_13"
    )
  end

  it "updates a loyalty card" do
    visit edit_loyalty_card_path(loyalty_card, locale: :en)

    fill_in LoyaltyCard.human_attribute_name(:store), with: "New Store"
    fill_in LoyaltyCard.human_attribute_name(:code), with: "222"
    select I18n.t("enumerize.loyalty_card.barcode_type.qr_code"), from: LoyaltyCard.human_attribute_name(:barcode_type)
    click_on I18n.t("helpers.submit.update", model: I18n.t("activerecord.models.loyalty_card.one"))

    expect(page).to have_content("New Store")
    expect(page).to have_content("222")

    expect(LoyaltyCard.last).to have_attributes(
      user:,
      store: "New Store",
      code: "222",
      barcode_type: "qr_code"
    )
  end

  it "deletes a loyalty card" do
    visit loyalty_card_path(loyalty_card, locale: :en)

    expect do
      click_on I18n.t("loyalty_cards.show.delete")
    end.to change(LoyaltyCard, :count).by(-1)

    expect(page).not_to have_content loyalty_card.store
    expect(page).not_to have_content loyalty_card.code
    expect { loyalty_card.reload }.to raise_error(ActiveRecord::RecordNotFound)
  end
end
