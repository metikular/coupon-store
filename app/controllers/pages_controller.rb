# frozen_string_literal: true

class PagesController < PublicController
  VALID_PAGES = %w[home data_privacy].freeze

  def show
    id = params[:id]
    raise ActiveRecord::RecordNotFound unless VALID_PAGES.include? id

    render "pages/#{id}"
  end

  def page_classes
    return "bg-white" if params[:id] == "home"

    super
  end

  def body_classes
    "p-6"
  end
end
