FactoryGirl.define do
  factory :campaign do
    association :user, factory: :user
    sequence(:title) { |n| "#{Faker::Company.bs}-#{n}" }
    description Faker::Lorem.paragraph
    goal 100000000
    due_date "2019-11-11 10:33:20"
  end

end
