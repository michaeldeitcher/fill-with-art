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
    anonymous_token Faker::Internet.device_token

    trait :with_contributions do
      after(:create) do |bundle|
        create_list :bundle_contribution, 2, bundle: bundle
      end
    end
  end

  factory :bundle_contribution do
    text Faker::StarTrek.location
    image {FilesTestHelper.jpg}
    anonymous_token Faker::Internet.device_token
  end
end