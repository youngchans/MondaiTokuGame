class Task < ApplicationRecord
  belongs_to :quest
  validates :similar_word, presence: true
end
