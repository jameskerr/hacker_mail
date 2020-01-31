class CreateSamples < ActiveRecord::Migration[6.0]
  def change
    create_table :samples do |t|
      t.datetime :ts
      t.integer :score
      t.references :story, null: false, foreign_key: true
    end
    add_index :samples, :ts
  end
end
