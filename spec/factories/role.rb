FactoryBot.define do
  factory :role do
    name { Faker::Lorem.sentences.sample }
  end
end
