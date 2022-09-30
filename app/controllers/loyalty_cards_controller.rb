# frozen_string_literal: true

class LoyaltyCardsController < ApplicationController
  load_and_authorize_resource through: :current_user

  def index
    @loyalty_cards = @loyalty_cards.sorted_by_store
  end

  def show
  end

  def new
  end

  def create
    @preview = params[:commit] == "preview"

    if !@preview && @loyalty_card.save
      redirect_to loyalty_cards_path
    else
      render :new
    end
  end

  def edit
  end

  def update
    @preview = params[:commit] == "preview"

    if !@preview && @loyalty_card.update(loyalty_card_params)
      redirect_to @loyalty_card
    else
      render :edit
    end
  end

  def destroy
    @loyalty_card.destroy!

    redirect_to loyalty_cards_path
  end

  def body_classes
    case params[:action]
    when "index"
      ""
    else
      "p-6"
    end
  end

  private

  def loyalty_card_params
    params
      .require(:loyalty_card)
      .permit(
        :code,
        :barcode_type,
        :store
      )
  end
end
