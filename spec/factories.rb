FactoryBot.define do
  factory :user do
    username Faker::Internet.username
    email Faker::Internet.email
    password Faker::Internet.password
  end

  factory :bundle do
    title Faker::StarTrek.location
    association :creator, factory: :user
    image {FilesTestHelper.jpg}
  end

  factory :bundle_section do

  end
end