class Tag < ApplicationRecord
  has_and_belongs_to_many :tasks
  validates :name, uniqueness: true
end
