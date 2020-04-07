class Subscriber < ApplicationRecord
  has_many :sent_stories
  has_many :stories, through: :sent_stories, dependent: :destroy

  validates :email, :threshold, presence: true

  after_initialize :generate_key

  def generate_key
    self.key = SecureRandom.uuid if key.blank?
  end

  def to_param
    key
  end
end
