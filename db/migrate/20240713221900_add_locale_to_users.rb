class AddLocaleToUsers < ActiveRecord::Migration[7.1]
  def change
    add_column :users, :locale, :string, null: false, default: "en"
  end
end
