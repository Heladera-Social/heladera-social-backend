FactoryGirl.define do
  factory :user do
    name { Faker::Name.first_name }
    last_name { Faker::Name.last_name }
    email { Faker::Internet.safe_email }
    password { Faker::Internet.password }
    telephone { Faker::PhoneNumber.phone_number }
  end
end