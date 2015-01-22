FactoryGirl.define do
  factory :inspection do
    sequence(:name) { |n| "Inspection No. #{n}"}
    subject "Lorem ipsum dolor sit amet."
    period "Lorem ipsum dolor sit amet."
    norm "Lorem ipsum dolor sit amet."
    before_tips "Lorem ipsum dolor sit amet, consectetur cras amet."
    during_tips "Lorem ipsum dolor sit amet, consectetur cras amet."
    after_tips "Lorem ipsum dolor sit amet, consectetur cras amet."
    sanctions "Lorem ipsum dolor sit amet, consectetur cras amet."
    association :dependency
  end
end
