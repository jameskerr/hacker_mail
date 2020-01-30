class AddUniqueIndexToStoriesRemoteId < ActiveRecord::Migration[6.0]
  def change
    add_index :stories, :remote_id, unique: true
  end
end
