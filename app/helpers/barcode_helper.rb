module BarcodeHelper
  TYPES = %i[none ean_13 code_25_interleaved code_25_iata code_39 code_93 code_128 bookland ean_8 upc_supplemental qr_code upc_12].freeze

  def barcode_svg(barcode, barcode_type)
    return if barcode_type.blank? || barcode_type.to_sym == :none
    barcode = barcode.gsub(/\s+/, "")

    code = case barcode_type.to_sym
    when :ean_13
      # EAN has 12 digits and 1 check digit. The check digit must not be
      # provided to Barby.
      barcode = barcode[0..11]
      Barby::EAN13.new(barcode)
    when :code_25_interleaved
      Barby::Code25Interleaved.new(barcode)
    when :code_25_iata
      Barby::Code25IATA.new(barcode)
    when :code_39
      Barby::Code39.new(barcode)
    when :code_93
      Barby::Code93.new(barcode)
    when :code_128
      Barby::Code128.new(barcode)
    when :bookland
      Barby::Bookland.new(barcode)
    when :ean_8
      barcode = barcode[0..6]
      Barby::EAN8.new(barcode)
    when :upc_supplemental
      barcode = barcode[0..4]
      Barby::UPCSupplemental.new(barcode)
    when :qr_code
      Barby::QrCode.new(barcode)
    when :upc_12
      # When a leading '0' is added to UPC 12, it is the same as EAN 13
      barcode = ("0" + barcode)[0..11]
      Barby::EAN13.new(barcode)
    end

    code&.to_svg&.html_safe
  rescue
    ""
  end
end
