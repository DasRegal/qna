FactoryGirl.define do
  sequence :email do |n|
    "user#{n}@test.com"
  end
  
  factory :user do
    email
    password '12345678'
    password_confirmation '12345678'
    trait :with_questions do
      after(:create) do |user|
        create_list(:question, 5, user: user)
      end
    end
  end
end
