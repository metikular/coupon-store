# frozen_string_literal: true

RSpec.describe "signin" do
  let(:user) { create(:user, password:) }
  let(:password) { Faker::Internet.password }

  it "signs in as a new user" do
    visit root_path

    expect(page).to have_link I18n.t("actions.sign_in")
    within "header" do
      click_on I18n.t("actions.sign_in")
    end

    fill_in User.human_attribute_name(:email), with: user.email
    fill_in User.human_attribute_name(:password), with: password

    within ".form-actions" do
      click_on I18n.t("actions.sign_in")
    end

    expect(page).to have_link I18n.t("pages.home.go_to_coupons")
    expect(page).not_to have_link I18n.t("actions.sign_in")
  end
end
