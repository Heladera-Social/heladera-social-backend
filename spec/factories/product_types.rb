FactoryGirl.define do
  factory :product_type do
    name { Faker::Lorem.word }
    measurement_unit { Faker::Lorem.word }
  end
end