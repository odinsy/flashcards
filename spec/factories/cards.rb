FactoryGirl.define do
  factory :card do
    original_text " TeXt 1123 МиРуМ   "
    translated_text " aSd ФыВ  "
    review_date Date.today
  end
end
