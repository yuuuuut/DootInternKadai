FactoryBot.define do
  factory :message do
    body { 'Test' }
    user
    room
  end
end
