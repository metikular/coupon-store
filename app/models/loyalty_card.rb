class LoyaltyCard < ApplicationRecord
  extend Enumerize

  belongs_to :user

  has_one_attached :badge

  enumerize :barcode_type, in: BarcodeHelper::TYPES

  validates :code, presence: true

  scope :sorted_by_store, -> { order(:store) }
end
