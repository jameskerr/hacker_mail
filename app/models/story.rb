class Story < ApplicationRecord
  has_many :samples

  def self.upsert(opts)
    Story.create(opts)
  rescue ActiveRecord::RecordNotUnique
    story = Story.find(opts[:id])
    story.update(opts) if story
  end

  def max_score
    samples.maximum(:score)
  end

  def self.above(score)
    Story.find_by_sql("select * from stories")
  end
end
