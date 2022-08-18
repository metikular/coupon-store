class Coupon < ApplicationRecord
  belongs_to :user

  validates :code, presence: true

  scope :sorted_by_store, -> { order(:store) }
  scope :used, -> { where(used: true) }
  scope :valid, -> { where(used: false).where("valid_until IS NULL OR valid_until >= ?", Time.zone.now) }
  scope :expired, -> { where("valid_until < ?", Time.zone.now) }
end
