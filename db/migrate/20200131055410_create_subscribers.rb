class CreateSubscribers < ActiveRecord::Migration[6.0]
  def change
    create_table :subscribers do |t|
      t.string :email
      t.integer :threshold

      t.timestamps
    end
    add_index :subscribers, :email, unique: true
  end
end
