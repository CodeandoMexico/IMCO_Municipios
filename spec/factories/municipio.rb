FactoryGirl.define do
  factory :municipio do
    sequence(:nombre) { |n| "City No. #{n}"}
  end
end
