class User < ApplicationRecord
  has_secure_password
  has_many :tasks

  validates :name, :email, presence: true

end
