class AddDefaultToBarcodeTypeInCoupons < ActiveRecord::Migration[7.0]
  def change
    change_column_default :coupons, :barcode_type, from: nil, to: "none"
  end
end
