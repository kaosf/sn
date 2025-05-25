FactoryBot.define do
  factory :sn do
    sequence(:uuid) { SecureRandom.uuid }
    title { 'Title' }
    body { 'Body' }
    read { 0 }
  end
end
