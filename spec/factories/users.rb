FactoryGirl.define do
  factory :user do
    sequence(:email) { |n| "user_#{n}@website.com" }
    password 'some_secure_password'
    admin false
    sequence(:name) { |n| "User #{n}"}
    association :city

    trait :with_profile do
      address 'This is a fake address'
      business_name 'This is a business name'
      operation_license 'AN49FN40865J'
      line_id '0'
      operation_license_file { Rack::Test::UploadedFile.new(File.join(Rails.root, 'spec', 'fixtures', 'operation_license_dummy.pdf')) }
      land_permission_file { Rack::Test::UploadedFile.new(File.join(Rails.root, 'spec', 'fixtures', 'land_permission_dummy.pdf')) }
    end
  end


  factory :admin, parent: :user do
    sequence(:email) { |n| "admin_#{n}@website.com"}
    password "some_secure_password"
    admin true
  end


end
