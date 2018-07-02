FactoryBot.define do
  factory :establishment do
    name {Faker::Company.unique.name}
    google_places_id {Faker::Number.unique.number(10)}

    trait :with_google_place_data do
      google_place do
        {
          "types" => ["bar"],
          "phone_number" => Faker::PhoneNumber.unique.phone_number,
          "address" => Faker::Address.unique.full_address,
          "rating" => rand(1.0..5.0).round(1),
          "website" => Faker::Internet.unique.url,
          "schedule" => [
            {"open" => {"day" => 0, "time" => "1100"}, "close" => {"day" => 1, "time" => "0000"}},
            {"open" => {"day" => 1, "time" => "1100"}, "close" => {"day" => 2, "time" => "0000"}},
            {"open" => {"day" => 2, "time" => "1100"}, "close" => {"day" => 3, "time" => "0000"}},
            {"open" => {"day" => 3, "time" => "1100"}, "close" => {"day" => 4, "time" => "0300"}},
            {"open" => {"day" => 4, "time" => "1100"}, "close" => {"day" => 5, "time" => "0300"}},
            {"open" => {"day" => 5, "time" => "1100"}, "close" => {"day" => 6, "time" => "0400"}},
            {"open" => {"day" => 6, "time" => "1100"}, "close" => {"day" => 0, "time" => "0400"}}
          ],
          "photos" => 3.times.map {Faker::Internet.unique.url}
        }
      end
    end
  end
end
