# frozen_string_literal: true

class User < ApplicationRecord
has_secure_password
  validates :name, presence: true, uniqueness: true
attribute :birth_date, :date

end
