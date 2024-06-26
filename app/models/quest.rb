require 'csv'
class Quest < ApplicationRecord
  has_many :quest_tags
  has_many :tags, through: :quest_tags
  has_many :tasks, dependent: :destroy, inverse_of: :quest
  accepts_nested_attributes_for :tasks, allow_destroy: true, reject_if: :all_blank, update_only: true
  validates :question, presence: true, uniqueness: true
  validates :description, presence: true
end
