class CreateCharges < ActiveRecord::Migration[7.2]
  def change
    create_table :charges do |t|
      t.references :gift_card, null: false, foreign_key: true
      t.text :note
      t.monetize :amount

      t.timestamps
    end
  end
end
