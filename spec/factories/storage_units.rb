FactoryGirl.define do
  factory :storage_unit do
    name { Faker::Company.name }
    email { Faker::Internet.safe_email }
    telephone { Faker::PhoneNumber.phone_number }
    address { Faker::Address.street_address }
    latitude { Faker::Address.latitude }
    longitude { Faker::Address.longitude }
  end
end