class CreateCoupons < ActiveRecord::Migration[7.0]
  def change
    create_table :coupons do |t|
      t.string :store
      t.string :code
      t.string :description
      t.date :valid_until
      t.string :barcode_type
      t.boolean :used, default: false, null: false
      t.references :user, null: false, foreign_key: true

      t.timestamps
    end
  end
end
