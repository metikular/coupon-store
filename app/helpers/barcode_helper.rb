module BarcodeHelper
  TYPES = %i[none ean_13].freeze

  def barcode_svg(barcode, barcode_type)
    return if barcode_type.blank? || barcode_type.to_sym == :none

    case barcode_type.to_sym
    when :ean_13
      Barby::EAN13.new(barcode).to_svg.html_safe
    end
  end
end
