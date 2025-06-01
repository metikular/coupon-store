# frozen_string_literal: true

class GiftCardsController < ApplicationController
  load_and_authorize_resource through: :current_user

  def index
    @gift_cards = @gift_cards.sorted_by_name
  end

  def show
  end

  def new
  end

  def create
    if @gift_card.save
      redirect_to gift_cards_path
    else
      render :new, status: :unprocessable_entity
    end
  end

  def edit
  end

  def update
    if @gift_card.update(gift_card_params)
      redirect_to @gift_card
    else
      render :edit, status: :unprocessable_entity
    end
  end

  def destroy
    @gift_card.destroy!

    redirect_to gift_cards_path
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

  def gift_card_params
    params
      .require(:gift_card)
      .permit(
        :name,
        :currency,
        :balance
      )
  end
end
