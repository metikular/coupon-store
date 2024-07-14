class AddExpirationNotificationSettingsToUsers < ActiveRecord::Migration[7.1]
  def change
    add_column :users, :expiration_notification_days, :integer
    add_column :users, :expiration_notification_title, :string
    add_column :users, :expiration_notification_body, :string
    add_column :users, :expiration_notification_channels, :string
  end
end
