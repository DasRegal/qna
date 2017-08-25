FactoryGirl.define do
  sequence :title do |n|
    "Title  text#{n}"
  end

  sequence :body do |n|
    "Question text#{n}"
  end
  
  factory :question do
    title
    body
    user

    trait :with_answers do
      after(:create) do |question|
        create_list(:answer, 5, question: question)
      end
    end
  end
  
  factory :invalid_question, class: "Question" do
    title nil
    body  nil
    user
  end
end