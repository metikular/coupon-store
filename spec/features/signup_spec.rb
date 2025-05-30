# frozen_string_literal: true

RSpec.describe "signup" do
  let(:email) { Faker::Internet.email }
  let(:password) { Faker::Internet.password }

  it "creates a new user" do
    visit root_path

    expect(page).to have_link I18n.t("actions.sign_up")
    within "header" do
      click_on I18n.t("actions.sign_up")
    end

    fill_in User.human_attribute_name(:email), with: email
    fill_in "user[password]", with: password
    fill_in User.human_attribute_name(:password_confirmation), with: password

    expect do
      within ".form-actions" do
        click_on I18n.t("actions.sign_up")
      end
    end.to change(User, :count).by(1)

    expect(page).to have_link I18n.t("pages.home.go_to_coupons")

    expect(User.last).to have_attributes(email:)
    expect(User.last.valid_password?(password)).to be true
  end
end
