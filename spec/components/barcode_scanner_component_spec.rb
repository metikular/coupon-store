# frozen_string_literal: true

require "rails_helper"

RSpec.describe BarcodeScannerComponent, type: :component do
  it "renders a modal" do
    expect(
      render_inline(described_class.new)
    ).to have_css '.modal[data-barcode-scanner-target="modal"]'
  end
end
