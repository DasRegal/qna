FactoryGirl.define do
  factory :answer do
    title "MyString"
    body  "MyText"
    user
    association :question
  end
  
  factory :invalid_answer, class: "Answer" do
    title nil
    body  nil
    user
    association :question
  end
end