FactoryBot.define do
  factory :post do
    category { FactoryBot.create(:category) }
    user { FactoryBot.create(:user) }
    title { Faker::Lorem.sentences.sample }
    text { Faker::Lorem.sentences.sample }
  end
end
