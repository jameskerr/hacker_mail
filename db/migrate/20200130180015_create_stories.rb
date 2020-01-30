class CreateStories < ActiveRecord::Migration[6.0]
  def change
    create_table :stories do |t|
      t.string :title, null: false
      t.string :link, null: false
      t.integer :remote_id, null: false

      t.timestamps
    end
  end
end
