# frozen_string_literal: true

module GiftCards
  class BadgesController < ApplicationController
    load_and_authorize_resource :gift_card, through: :current_user, parent: true

    def destroy
      @gift_card.badge.purge

      redirect_to gift_card_path(@gift_card)
    end
  end
end
