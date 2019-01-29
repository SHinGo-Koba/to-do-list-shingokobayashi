FactoryBot.define do
  factory :user do
    sequence(:name) { |n| "name#{n}" }
    email { "#{name}@example.com" }
    password { "#{name}1234" }
    password_confirmation { "#{password}" }
  end
end