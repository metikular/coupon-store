# frozen_string_literal: true

RSpec.describe "account" do
  let(:user) { create(:user) }

  before do
    login_as user
  end

  it "deletes an account" do
    visit root_path

    click_on I18n.t("navigation.account")

    expect(page).to have_content I18n.t("users.show.email_address")
    expect(page).to have_content user.email

    expect do
      click_on I18n.t("users.show.delete_my_account")
    end.to change(User, :count).by(-1)

    expect { user.reload }.to raise_error(ActiveRecord::RecordNotFound)
  end

  context "with coupons, loyalty cards and gift cards" do
    let!(:coupon) { create(:coupon, user:) }
    let!(:loyalty_card) { create(:loyalty_card, user:) }
    let!(:gift_card) { create(:gift_card, user:) }

    it "deletes an account" do
      visit user_path(locale: :en)

      expect do
        click_on I18n.t("users.show.delete_my_account")
      end.to change(User, :count).by(-1)

      expect { user.reload }.to raise_error(ActiveRecord::RecordNotFound)
    end
  end

  it "updates the email address" do
    visit user_path(locale: :en)

    click_on I18n.t("users.show.email.edit")
    expect(page).to have_css "h1", text: I18n.t("users.edit.title")

    new_email = "new@example.com"
    fill_in User.human_attribute_name(:email), with: new_email

    click_on I18n.t("helpers.submit.update", model: I18n.t("activerecord.models.user.one"))

    expect(page).to have_current_path user_path(locale: :en)
    expect(page).to have_content new_email

    user.reload
    expect(user.email).to eq new_email
  end

  it "shows an error on validation errors" do
    visit user_path(locale: :en)

    click_on I18n.t("users.show.email.edit")
    expect(page).to have_css "h1", text: I18n.t("users.edit.title")

    fill_in User.human_attribute_name(:email), with: ""

    click_on I18n.t("helpers.submit.update", model: I18n.t("activerecord.models.user.one"))

    expect(page).to have_content I18n.t("errors.messages.blank")
    expect(user.reload.email).to be_present
  end
end
