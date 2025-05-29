# frozen_string_literal: true

require "rails_helper"

RSpec.describe "homepage" do
  context "when not logged in" do
    it "shows the homepage" do
      visit root_path

      expect(page).to have_css "h1", text: I18n.t("pages.home.title")
      expect(page).to have_link I18n.t("actions.sign_up")
      expect(page).to have_link I18n.t("actions.sign_in")
    end

    it "does not show a link to the data privacy" do
      visit root_path

      expect(page).not_to have_link I18n.t("footer.data_privacy")
    end

    context "with a data privacy" do
      before do
        allow_any_instance_of(ActionView::LookupContext).to receive(:exists?).with("data_privacy", "pages").and_return(true)
      end

      it "shows a link and allows to access it" do
        visit root_path

        expect(page).to have_link I18n.t("footer.data_privacy")
      end
    end
  end

  context "when logged in" do
    let(:user) { create(:user) }

    before do
      login_as user
    end

    it "shows the homepage" do
      visit root_path

      expect(page).to have_css "h1", text: I18n.t("pages.home.title")
      expect(page).not_to have_link I18n.t("actions.sign_up")
      expect(page).not_to have_link I18n.t("actions.sign_in")
      expect(page).to have_link I18n.t("navigation.account")
      expect(page).to have_link I18n.t("pages.home.go_to_coupons")
    end
  end
end
