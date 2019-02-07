class User < ApplicationRecord
  has_secure_password
  has_many :tasks

  validates :name, :email, presence: true
  validates :password, presence: true, length: { minimum: 6 }

end
