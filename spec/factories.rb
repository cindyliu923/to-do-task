FactoryBot.define do
  factory :user do
    
  end
  factory :task do
    sequence(:title) { |n| "task title #{n}" }
    sequence(:content) { |n| "task content #{n}" }
    deadline { 2.days.from_now }
    status { :todo }
    priority { :low }

    trait :deadline_later do
      deadline { 20.days.from_now }
    end

    trait :deadline_earlier do
      deadline { 1.days.from_now }
    end

    trait :doing do
      status { :doing }
    end

    trait :done do
      status { :done }
    end

    trait :medium do
      priority { :medium }
    end

    trait :high do
      priority { :high }
    end

  end
end
