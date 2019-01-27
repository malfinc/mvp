FactoryBot.define do
  factory(:account) do
    name {Faker::Name.name()}
    email {Faker::Internet.unique.email()}
    password {Faker::Internet.unique.password()}

    trait(:confirmed) do
      after(:create, &:confirm)
    end

    trait(:customized_username) do
      email {Faker::Internet.unique.username()}
    end

    trait(:completed) do
      after(:create, &:complete!)
    end

    trait(:administrator) do
      after(:create, &:upgrade_to_administrator!)
    end
  end
end
