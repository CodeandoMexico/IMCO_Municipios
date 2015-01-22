FactoryGirl.define do
  factory :dependency do
    sequence(:nombre) { |n| "Dependency No. #{n}" }
    association :municipio
  end
end
