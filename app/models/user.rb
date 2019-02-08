class User < ApplicationRecord
  ROLES = %i[normal admin]
  has_secure_password
  has_many :tasks, :dependent => :destroy

  validates :name, :email, presence: true
  validates :password, presence: true, length: { minimum: 6 }
  validates :email, format: { with: /\A([\w\.%\+\-]+)@([\w\-]+\.)+([\w]{2,})\z/i }, uniqueness: { case_sensitive: false }

  before_destroy :check_destroy
  before_update :check_update

  def admin?
    self.role == "admin"
  end

  def localized_role
    I18n.t("users.role.#{self.role}")
  end

  protected

  def last_admin?
    User.where(role: "admin").size == 1
  end

  def check_destroy
    if self.admin? && self.last_admin?
      throw :abort
    end
  end

  def check_update
    if !self.admin? && self.last_admin?
      throw :abort
    end
  end

  class << self

    def select_options_by_role
      User::ROLES.map{ |x| [I18n.t("users.role.#{x}"),x] }
    end

  end

end
