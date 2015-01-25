FactoryGirl.define do
  factory :user do
    sequence(:email) { |n| "user_#{n}@website.com" }
    password "some_secure_password"
    admin false

    association :municipio
  end

  factory :admin, parent: :user do
    sequence(:email) { |n| "admin_#{n}@website.com"}
    password "some_secure_password"
    admin true
  end
end
