class SentStory < ApplicationRecord
  belongs_to :story
  belongs_to :subscriber
end
