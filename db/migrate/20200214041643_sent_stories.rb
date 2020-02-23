class SentStories < ActiveRecord::Migration[6.0]
  def change
    create_table :sent_stories, id: false do |t|
      t.references :subscriber, foreign_key: true
      t.references :story, foreign_key: true
    end
  end
end
