class Task < ApplicationRecord
  include AASM
  belongs_to :user

  validates :title, :content, presence: true

  enum status: { todo: 0, doing: 1, done: 2 }
  enum priority: { low: 0, medium: 1, high: 2 }

  aasm :column => :status, :enum => true do
    state :todo, :initial => true
    state :doing, :done

    event :up do
      transitions from: :todo, to: :doing
    end

    event :down do
      transitions from: :doing, to: :done
    end
  end

  def localized_status
    I18n.t("tasks.status.#{self.status}")
  end

  def localized_priority
    I18n.t("tasks.priority.#{self.priority}")
  end

  class << self

    def select_options_by_priority
      priorities.keys.map{|x| [I18n.t("tasks.priority.#{x}"), x]}
    end

    def select_options_by_status
      statuses.map{|k,v| [I18n.t("tasks.status.#{k}"), v]}
    end

  end
end
