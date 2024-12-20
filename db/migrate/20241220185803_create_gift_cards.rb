class CreateGiftCards < ActiveRecord::Migration[7.2]
  def change
    create_table :gift_cards do |t|
      t.references :user, null: false, foreign_key: true
      t.string :name, null: false
      t.string :currency, null: false
      t.monetize :balance

      t.timestamps
    end
  end
end
