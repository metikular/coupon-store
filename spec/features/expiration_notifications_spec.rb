# frozen_string_literal: true

require "rails_helper"

RSpec.describe "manage expiration notification settings" do
  let(:user) { create(:user) }
  let(:apprise_url) { "rockets://user:password@chat.coupon.example/#apprise?avatar=false" }

  before do
    login_as user
  end

  it "creates expiration notification settings" do
    visit user_path(locale: :en)
    expect(page).to have_content I18n.t("users.show.expiration_notification.title")

    click_on I18n.t("users.show.expiration_notification.edit")
    expect(page).to have_css "h1", text: I18n.t("users.expiration_notifications.edit.title")

    fill_in User.human_attribute_name(:expiration_notification_days), with: 3
    fill_in User.human_attribute_name(:expiration_notification_title), with: "Expiring soon!"
    fill_in User.human_attribute_name(:expiration_notification_body), with: "Your coupon is about to expire."
    fill_in "user[expiration_notification_channels][]", with: apprise_url

    click_on I18n.t("helpers.submit.update", model: I18n.t("activerecord.models.user.one"))

    expect(page).to have_current_path user_path(locale: :en)
    user.reload
    expect(user).to have_attributes(
      expiration_notification_days: 3,
      expiration_notification_title: "Expiring soon!",
      expiration_notification_body: "Your coupon is about to expire.",
      expiration_notification_channels: match_array([apprise_url])
    )
  end

  it "updates expiration notification settings" do
    user.update!(
      expiration_notification_days: 2,
      expiration_notification_title: "Old title",
      expiration_notification_body: "Old body",
      expiration_notification_channels: []
    )

    visit user_path(locale: :en)
    click_on I18n.t("users.show.expiration_notification.edit")

    fill_in User.human_attribute_name(:expiration_notification_days), with: 5
    fill_in User.human_attribute_name(:expiration_notification_title), with: "New title"
    fill_in User.human_attribute_name(:expiration_notification_body), with: "New body"
    fill_in "user[expiration_notification_channels][]", with: apprise_url

    click_on I18n.t("helpers.submit.update", model: I18n.t("activerecord.models.user.one"))

    user.reload
    expect(user).to have_attributes(
      expiration_notification_days: 5,
      expiration_notification_title: "New title",
      expiration_notification_body: "New body",
      expiration_notification_channels: match_array([apprise_url])
    )
  end

  it "deletes expiration notification settings" do
    user.update!(
      expiration_notification_days: 2,
      expiration_notification_title: "Title",
      expiration_notification_body: "Body",
      expiration_notification_channels: [apprise_url]
    )

    visit user_path(locale: :en)
    click_on I18n.t("users.show.expiration_notification.edit")

    fill_in User.human_attribute_name(:expiration_notification_days), with: ""
    fill_in User.human_attribute_name(:expiration_notification_title), with: ""
    fill_in User.human_attribute_name(:expiration_notification_body), with: ""
    # Remove all channels
    all("input[name='user[expiration_notification_channels][]']").each { |input| input.set("") }

    click_on I18n.t("helpers.submit.update", model: I18n.t("activerecord.models.user.one"))

    user.reload
    expect(user).to have_attributes(
      expiration_notification_days: nil,
      expiration_notification_title: "",
      expiration_notification_body: "",
      expiration_notification_channels: be_empty
    )
  end
end
