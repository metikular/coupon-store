class CreateLoyaltyCards < ActiveRecord::Migration[7.0]
  def change
    create_table :loyalty_cards do |t|
      t.string :store
      t.string :code
      t.string :barcode_type, default: "none"
      t.references :user, null: false, foreign_key: true

      t.timestamps
    end
  end
end
