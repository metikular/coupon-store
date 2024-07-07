# frozen_string_literal: true

class SearchesController < ApplicationController
  authorize_resource class: false

  def show
    @search = Forms::Search.new(search_params)
  end

  private

  def search_params
    params.permit(:q, :type)
  end
end
