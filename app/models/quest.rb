class Quest < ApplicationRecord
  has_many :tasks, dependent: :destroy, inverse_of: :quest
  accepts_nested_attributes_for :tasks, allow_destroy: true, reject_if: :all_blank, update_only: true
end
