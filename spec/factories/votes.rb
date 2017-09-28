FactoryGirl.define do
  factory :vote do
    user nil
    votable_id 1
    votable_type "MyString"
    
    trait :up do
      count 1
    end
    
    trait :down do
      count -1
    end
  end
end
