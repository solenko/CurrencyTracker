FactoryGirl.define do
  factory :currency do
    name { Faker::Name.name }
    code { Faker::Address. country_code }
    country
  end
end