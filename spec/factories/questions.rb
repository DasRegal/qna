FactoryGirl.define do
  factory :question do
    title "MyString"
    body  "MyText"
    
    trait :with_answers do
      after(:create) do |question|
        create_list(:answer, 5, question: question)
      end
    end
  end
  
  factory :invalid_question, class: "Question" do
    title nil
    body  nil
  end
end