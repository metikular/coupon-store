# frozen_string_literal: true

require "rails_helper"

RSpec.describe Ops::Coupon::Expiration::Notify do
  let(:coupon) do
    create(
      :coupon,
      user:,
      store: "Test Store",
      code: "123456",
      description: "10% off",
      valid_until: Date.tomorrow
    )
  end

  subject(:operation) { described_class.new(coupon:).call }

  describe "#call" do
    context "when user has notification settings" do
      let(:user) do
        create(
          :user,
          expiration_notification_days: 3,
          expiration_notification_title: "Expiring soon!",
          expiration_notification_body: "Your coupon {{code}} is expiring.",
          expiration_notification_channels: ["apprise://notify"]
        )
      end

      it "sends a notification" do
        expect(user).to have_notification_settings

        expect_any_instance_of(Kernel).to receive(:system).with(
          "/usr/bin/apprise",
          "--title",
          "Expiring soon!",
          "--body",
          "Your coupon 123456 is expiring.",
          "apprise://notify"
        )

        subject
      end
    end

    context "when user does not have notification settings" do
      let(:user) do
        create(
          :user,
          expiration_notification_days: nil,
          expiration_notification_title: "",
          expiration_notification_body: "",
          expiration_notification_channels: []
        )
      end

      it "does not send a notification" do
        expect(user).not_to have_notification_settings
        expect_any_instance_of(Kernel).not_to receive(:system)
      end
    end
  end
end
