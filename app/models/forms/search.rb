# frozen_string_literal: true

module Forms
  class Search
    include ActiveModel::Model
    include ActiveModel::Attributes

    attribute :q, :string
    attribute :type, :string, default: "coupon"

    validates :q, presence: true

    def self.model_name
      ActiveModel::Name.new(self, nil, "Search")
    end

    def initialize(attributes = {})
      super

      if type.blank? && count("coupon") == 0 && count("loyalty_card") > 0
        self.type = "loyalty_card"
      end

      self.type = type.presence || "coupon"
    end

    def query
      ActiveRecord::Base.sanitize_sql_like(q).presence || ""
    end

    def call
      search(type)
    end

    def count(search_type = type)
      search(search_type).count
    end

    def search(search_type)
      return [] if q.blank?

      case search_type
      when "coupon"
        Coupon
          .where(<<~SQL)
            store ILIKE '%#{query}%' OR
            code ILIKE '%#{query}%' OR
            description ILIKE '%#{query}%'
          SQL
      when "loyalty_card"
        LoyaltyCard
          .where(<<~SQL)
            store ILIKE '%#{query}%' OR
            code ILIKE '%#{query}%'
          SQL
      end
    end
  end
end
