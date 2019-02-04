class Task < ApplicationRecord
  include AASM

  validates :title, :content, presence: true

  enum status: { todo: 0, doing: 1, done: 2 }

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

end
