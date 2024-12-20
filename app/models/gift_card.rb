# frozen_string_literal: true

class GiftCard < ApplicationRecord
  belongs_to :user

  has_many :charges, dependent: :destroy

  validates :name, presence: true

  scope :sorted_by_name, -> { order(:name) }

  monetize :balance_cents
end
