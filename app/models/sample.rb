class Sample < ApplicationRecord
  belongs_to :story, dependent: :destroy

  scope :score_above, ->(score) { where("score >= ?", score) }
  scope :between, ->(from, to) { where("ts >= ?", from).where("ts < ?", to) }
  scope :story_ids, ->() { distinct.pluck(:story_id) }
end
