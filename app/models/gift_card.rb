# frozen_string_literal: true

class GiftCard < ApplicationRecord
  belongs_to :user

  has_many :charges, dependent: :destroy
  has_one_attached :badge

  validates :name, presence: true
  validates :currency, presence: true

  scope :sorted_by_name, -> { order(:name) }

  monetize :balance_cents
end
