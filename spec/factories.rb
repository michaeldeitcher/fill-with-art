FactoryBot.define do
  factory :bundle do
    title "MyString"
    creator nil
  end
  factory :user do
    username Faker::Internet.username
    email Faker::Internet.email
    password Faker::Internet.password
  end
end