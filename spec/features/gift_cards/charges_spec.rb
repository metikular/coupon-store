# frozen_string_literal: true

RSpec.describe "manage charges of gift cards", :js do
  let(:user) { create(:user) }
  let(:gift_card) { create(:gift_card, user:, balance: Money.from_amount(100, "USD"), currency: "USD") }

  before do
    login_as user
  end

  it "creates a charge" do
    visit gift_card_path(gift_card, locale: :en)

    click_on I18n.t("charges.index.new")
    fill_in Charge.human_attribute_name(:amount), with: 25
    fill_in Charge.human_attribute_name(:note), with: "Test charge"
    click_on I18n.t("helpers.submit.create", model: I18n.t("activerecord.models.charge.one"))

    expect(page).to have_content("Test charge")
    expect(page).to have_content("25")

    expect(gift_card.reload).to have_attributes(
      balance: Money.from_amount(75, "USD"),
      charges: [
        have_attributes(
          note: "Test charge",
          amount: Money.from_amount(25, "USD")
        )
      ]
    )
  end

  it "updates a charge" do
    charge = create(:charge, gift_card:, amount: Money.from_amount(10, "USD"), note: "Old note")

    expect(gift_card.reload).to have_attributes(balance: Money.from_amount(90, "USD"))

    visit gift_card_path(gift_card, locale: :en)

    within("##{dom_id(charge)}") do
      click_on I18n.t("charges.index.edit")
    end

    fill_in Charge.human_attribute_name(:amount), with: 15
    fill_in Charge.human_attribute_name(:note), with: "Updated note"
    click_on I18n.t("helpers.submit.update", model: I18n.t("activerecord.models.charge.one"))

    expect(page).to have_content("Updated note")
    expect(page).to have_content("15")
    expect(gift_card.reload).to have_attributes(
      balance: Money.from_amount(85, "USD"),
      charges: [
        have_attributes(
          note: "Updated note",
          amount: Money.from_amount(15, "USD")
        )
      ]
    )
  end

  it "deletes a charge" do
    charge = create(:charge, gift_card:, amount: Money.from_amount(10, "USD"))

    expect(gift_card.reload).to have_attributes(balance: Money.from_amount(90, "USD"))

    visit gift_card_path(gift_card, locale: :en)

    within("##{dom_id(charge)}") do
      accept_confirm { click_on I18n.t("charges.index.destroy") }
    end

    expect(page).not_to have_selector(dom_id(charge))
    expect(gift_card.reload).to have_attributes(
      balance: Money.from_amount(100, "USD"),
      charges: []
    )
  end

  context "when the charge is larger than the current balance" do
    it "stores the charge and shows a warning" do
      gift_card.update!(balance: Money.from_amount(10, "USD"))

      visit gift_card_path(gift_card, locale: :en)

      click_on I18n.t("charges.index.new")
      fill_in Charge.human_attribute_name(:amount), with: 25
      fill_in Charge.human_attribute_name(:note), with: "Test charge"
      click_on I18n.t("helpers.submit.create", model: I18n.t("activerecord.models.charge.one"))

      expect(page).to have_content("Test charge")
      expect(page).to have_content("25")

      expect(gift_card.reload).to have_attributes(
        balance: Money.from_amount(-15, "USD"),
        charges: [
          have_attributes(
            note: "Test charge",
            amount: Money.from_amount(25, "USD")
          )
        ]
      )
    end
  end
end
