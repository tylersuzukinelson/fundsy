FactoryGirl.define do
  factory :reward_level do
    campaign nil
    sequence(:title) { |n| "#{Faker::Company.bs}-#{n}"}
    amount 1
    body "MyText"
    quantity 1
  end

end
