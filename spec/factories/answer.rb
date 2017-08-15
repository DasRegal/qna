FactoryGirl.define do
  factory :answer do
    title "MyString"
    body  "MyText"
    association :question
  end
  
  factory :invalid_answer, class: "Answer" do
    title nil
    body  nil
    association :question
  end
end