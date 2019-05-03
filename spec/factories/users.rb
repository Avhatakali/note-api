FactoryBot.define do
  factory :user do
    username { Faker::Name.name }
    email { 'avha@bar.com' }
    password { 'avhabar' }
  end
end
