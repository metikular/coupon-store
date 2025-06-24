# frozen_string_literal: true

module LoyaltyCards
  class BadgesController < ApplicationController
    load_and_authorize_resource :loyalty_card, through: :current_user, parent: true

    def destroy
      @loyalty_card.badge.purge

      redirect_to loyalty_card_path(@loyalty_card)
    end
  end
end
