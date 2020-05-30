class Story < ApplicationRecord
  has_many :samples, dependent: :destroy
  has_many :sent_stories, dependent: :delete_all

  scope :join_max_score, -> {
          subquery = <<-SQL
      SELECT story_id, score, ROW_NUMBER() OVER (PARTITION BY story_id ORDER BY score DESC) as row
      FROM samples
    SQL
          joins("JOIN (#{subquery}) scores ON stories.id = scores.story_id AND scores.row = 1")
        }

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

  def self.next_up_for(subscriber)
    Story
      .join_max_score
      .select(:id, :title, :url, :score)
      .where(id: Sample
               .score_above(subscriber.threshold)
               .between(1.day.ago, Time.now)
               .story_ids)
      .where
      .not(id: subscriber.stories.ids)
      .order("score DESC")
  end
end
