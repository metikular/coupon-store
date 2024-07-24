# frozen_string_literal: true

module Ops
  module Coupon
    module Expiration
      class Notify
        include Rails.application.routes.url_helpers

        attr_reader :coupon

        delegate :user, to: :coupon

        def initialize(coupon:)
          @coupon = coupon
        end

        def call
          return unless user.has_notification_settings?

          I18n.with_locale user.locale do
            system(*command)
          end
        end

        private

        def template_options
          {
            "store" => coupon.store,
            "code" => coupon.code,
            "description" => coupon.description,
            "valid_until" => coupon.valid_until.present? ? I18n.l(coupon.valid_until) : "",
            "url" => coupon_url(
              user.locale,
              coupon,
              host: Rails.application.config.action_controller.default_url_options[:host],
              port: Rails.application.config.action_controller.default_url_options[:port]
            )
          }
        end

        def command
          title = Liquid::Template
            .parse(user.expiration_notification_title.presence || I18n.t("coupon.expiration.title.default"))
            .render(template_options)

          body = Liquid::Template
            .parse(user.expiration_notification_body.presence || I18n.t("coupon.expiration.body.default"))
            .render(template_options)

          channels = user.expiration_notification_channels

          [
            "/usr/bin/apprise",
            "--title",
            title,
            "--body",
            body,
            *channels
          ]
        end
      end
    end
  end
end
