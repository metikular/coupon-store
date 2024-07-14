class User < ApplicationRecord
  # Include default devise modules. Others available are:
  # :confirmable, :lockable, :timeoutable, :trackable and :omniauthable
  devise :database_authenticatable, :registerable,
    :recoverable, :rememberable, :validatable

  has_many :coupons
  has_many :loyalty_cards

  def remember_me
    super.nil? ? true : super
  end

  def expiration_notification_channels=(channels)
    raise ArgumentError, "expiration_notification_channels must be an array" unless channels.is_a?(Array)

    super(channels.compact_blank.join(","))
  end

  def expiration_notification_channels
    super&.split(",") || []
  end

  def has_notification_settings?
    expiration_notification_days.present? &&
      expiration_notification_channels.present?
  end
end
