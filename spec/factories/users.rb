FactoryGirl.define do
  factory :user do
    sequence(:email) { |n| "valid_email#{n}@gmail.com" }
    first_name Faker::Name.first_name
    last_name Faker::Name.last_name
    password Faker::Internet.password(12)
  end

end
