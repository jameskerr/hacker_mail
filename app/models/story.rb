class Story < ApplicationRecord
  has_many :samples

  def self.upsert(opts)
    Story.create(opts)
  rescue ActiveRecord::RecordNotUnique
    story = Story.find(opts[:id])
    story.update(opts) if story
  end
end
