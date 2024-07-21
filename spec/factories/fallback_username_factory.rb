FactoryBot.define do
  factory :fallback_username do
    username { Faker::Lorem::Letters.sample(3).join.upcase }
  end
end
