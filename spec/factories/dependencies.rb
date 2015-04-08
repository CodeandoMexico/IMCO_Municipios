FactoryGirl.define do
  factory :dependency do
    sequence(:name) { |n| "Dependency No. #{n}" }
    association :city
  end
end
