FactoryBot.define do
  factory :category do
    name { Faker::Lorem.sentences.sample }
  end
end
