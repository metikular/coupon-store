# frozen_string_literal: true

class BarcodesController < ApplicationController
  authorize_resource class: false

  def show
    @code = params[:code]
    @type = params[:type]
    @id = ["barcode", @type, @code].join("_")
  end
end
