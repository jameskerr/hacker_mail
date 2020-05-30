class Sample < ApplicationRecord
  belongs_to :story

  scope :score_above, ->(score) { where("score >= ?", score) }
  scope :between, ->(from, to) { where("ts >= ?", from).where("ts < ?", to) }
  scope :story_ids, ->() { distinct.pluck(:story_id) }

  after_initialize :set_ts

  def set_ts
    self.ts = Time.now if ts.nil?
  end
end
