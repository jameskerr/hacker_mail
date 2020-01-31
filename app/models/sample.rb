class Sample < ApplicationRecord
  belongs_to :story, dependent: :destroy
end
