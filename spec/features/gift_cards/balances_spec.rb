# frozen_string_literal: true

RSpec.describe "sets the balance", :js do
  let(:user) { create(:user) }
  let(:gift_card) { create(:gift_card, user:, balance: Money.from_amount(100, "USD"), currency: "USD") }

  before do
    login_as user
  end

  it "creates a new charge" do
    visit gift_card_path(gift_card, locale: :en)

    click_on I18n.t("charges.index.set_balance")
    fill_in GiftCard.human_attribute_name(:balance), with: 60
    click_on I18n.t("charges.index.set_balance")

    expect(page).to have_content(I18n.t("charge.note.setting_balance"))
    expect(page).to have_content("40")

    expect(gift_card.reload).to have_attributes(
      balance: Money.from_amount(60, "USD"),
      charges: [
        have_attributes(
          note: I18n.t("charge.note.setting_balance"),
          amount: Money.from_amount(-40, "USD")
        )
      ]
    )
  end
end
