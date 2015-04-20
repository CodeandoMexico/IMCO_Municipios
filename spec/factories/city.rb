FactoryGirl.define do
  factory :city do
    sequence(:name) { |n| "City No. #{n}"}
  end
end
