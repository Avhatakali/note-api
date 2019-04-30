FactoryBot.define do
  factory :note do
    content { Faker::Lorem.word }
    created_by { Faker::Number.number(10) }
  end
end
