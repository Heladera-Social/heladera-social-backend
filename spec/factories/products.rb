FactoryGirl.define do
  factory :product do
    quantity { Faker::Number.decimal(2) }
    expiration_date do
      Faker::Time.between(Time.zone.today, Time.zone.today + 1.week, :all).to_date
    end
  end
end
