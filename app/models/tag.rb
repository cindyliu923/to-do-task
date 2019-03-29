class Tag < ApplicationRecord
  has_and_belongs_to_many :tasks
  validates :name, uniqueness: true

  def self.ransackable_attributes(auth_object = nil)
    %w(name)
  end
end
