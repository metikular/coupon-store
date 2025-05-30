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
end
