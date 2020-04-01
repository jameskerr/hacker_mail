class AddConfirmationToSubscribers < ActiveRecord::Migration[6.0]
  def change
    add_column :subscribers, :confirmed, :boolean, default: false, null: false
    add_column :subscribers, :key, :string
  end
end
