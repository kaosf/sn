FactoryBot.define do
  factory :user do
    sequence(:email_address) { "#{_1}@example.com" }
    password { 'password' }
  end
end
