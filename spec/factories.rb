FactoryBot.define do
  factory :task do
    sequence(:title) { |n| "task title #{n}" }
    sequence(:content) { |n| "task content #{n}" }
    deadline { 2.days.from_now }

    trait :deadline_later do
      deadline { 20.days.from_now }
    end

    trait :deadline_earlier do
      deadline { 1.days.from_now }
    end
  end
end
