class User < ApplicationRecord
  ROLES = %i[normal admin]
  has_secure_password
  has_many :tasks, :dependent => :destroy

  validates :name, :email, presence: true
  validates :password, presence: true, length: { minimum: 6 }
  validates :email, format: { with: /\A([\w\.%\+\-]+)@([\w\-]+\.)+([\w]{2,})\z/i }, uniqueness: { case_sensitive: false }

  def admin?
    self.role == "admin"
  end

  def localized_role
    I18n.t("users.role.#{self.role}")
  end

  class << self

    def select_options_by_role
      User::ROLES.map{ |x| [I18n.t("users.role.#{x}"),x] }
    end

  end

end
