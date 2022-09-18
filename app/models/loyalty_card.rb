class LoyaltyCard < ApplicationRecord
  extend Enumerize

  belongs_to :user

  enumerize :barcode_type, in: BarcodeHelper::TYPES

  validates :code, presence: true

  scope :sorted_by_store, -> { order(:store) }
end
