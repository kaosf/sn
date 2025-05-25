FactoryBot.define do
  factory :sn_subscription do
    endpoint { 'e' }
    p256dh { 'p' }
    auth { 'a' }
  end
end
