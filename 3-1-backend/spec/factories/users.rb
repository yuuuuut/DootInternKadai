FactoryBot.define do
  factory :user do
    name     { "TestUser" }
    email    { "Test@test.com"}
    password { "password" }
  end
end
