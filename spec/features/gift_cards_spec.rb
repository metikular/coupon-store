# frozen_string_literal: true

require "rails_helper"

RSpec.describe "manages gift cards" do
  let(:user) { create(:user) }
  let(:gift_card) { create(:gift_card, user:, name: "Old Card", currency: "USD") }

  before do
    login_as user
  end

  it "creates a gift card" do
    visit gift_cards_path(locale: :en)

    click_on I18n.t("gift_cards.new.title")
    expect(page).to have_css "h1", text: I18n.t("gift_cards.new.title")

    fill_in GiftCard.human_attribute_name(:name), with: "Test Card"
    select "USD", from: GiftCard.human_attribute_name(:currency)
    fill_in GiftCard.human_attribute_name(:balance), with: "100"

    expect do
      click_on I18n.t("helpers.submit.create", model: I18n.t("activerecord.models.gift_card.one"))
    end.to change(GiftCard, :count).by(1)

    expect(page).to have_content("Test Card")
    expect(GiftCard.last).to have_attributes(
      user:,
      name: "Test Card",
      currency: "USD",
      balance_cents: 100_00,
      balance_currency: "USD"
    )
  end

  it "shows a gift card" do
    visit gift_card_path(gift_card, locale: :en)

    expect(page).to have_content gift_card.name
  end

  it "updates a gift card" do
    visit edit_gift_card_path(gift_card, locale: :en)

    fill_in GiftCard.human_attribute_name(:name), with: "Updated Card"
    click_on I18n.t("helpers.submit.update", model: I18n.t("activerecord.models.gift_card.one"))

    expect(page).to have_content("Updated Card")
    expect(gift_card.reload.name).to eq "Updated Card"
  end

  it "deletes a gift card" do
    visit gift_card_path(gift_card, locale: :en)

    expect do
      click_on I18n.t("gift_cards.show.delete")
    end.to change(GiftCard, :count).by(-1)

    expect(page).not_to have_content "Old Card"
    expect { gift_card.reload }.to raise_error(ActiveRecord::RecordNotFound)
  end
end
