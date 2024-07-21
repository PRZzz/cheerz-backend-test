FactoryBot.define do
  factory :user do
    username { Faker::Lorem::Letters.sample(3).join.upcase }
  end
end
