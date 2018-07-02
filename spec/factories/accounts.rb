FactoryBot.define do
  factory :account do
    name { Faker::Name.name }
    email { Faker::Internet.unique.email }
    username { Faker::Internet.unique.user_name }
    password { Faker::Internet.unique.password }

    trait :confirmed do
      after(:create) do |record|
        record.confirm
      end
    end

    trait :completed do
      after(:create) do |record|
        record.completed!
      end
    end

    trait :moderator do
      after(:create) do |record|
        record.empower!
      end
    end

    trait :administrator do
      after(:create) do |record|
        record.spark!
      end
    end
  end
end
