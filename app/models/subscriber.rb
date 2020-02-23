class Subscriber < ApplicationRecord
  has_many :sent_stories
  has_many :stories, through: :sent_stories
end
