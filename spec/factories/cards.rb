FactoryGirl.define do
  factory :card do
    original_text " TexT МиР "
    translated_text " ТексТ WorlD "
    review_date Date.today
  end
end
