class Story < ApplicationRecord
  def self.upsert(opts)
    Story.create(opts)
  rescue ActiveRecord::RecordNotUnique
    story = Story.find_by(remote_id: opts[:remote_id])
    story.update(opts) if story
  end
end
