require "rails_helper"

RSpec.describe BarcodeHelper do
  it "returns an empty string when barcode is invalid for given type" do
    expect(helper.barcode_svg("0123", :ean_13)).to eq ""
  end

  it "returns an SVG when the barcode is valid" do
    expect(helper.barcode_svg("012345678901", :ean_13)).to be_present
  end

  it "returns an SVG even with whitespaces in the barcode" do
    expect(helper.barcode_svg("  01 23 4  5678901   ", :ean_13)).to be_present
    expect(helper.barcode_svg("  01 23 4  5678901   ", :ean_13)).to eq(helper.barcode_svg("012345678901", :ean_13))
  end
end
