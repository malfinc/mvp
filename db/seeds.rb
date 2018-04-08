# This file should contain all the record creation needed to seed the database with its default values.
# The data can then be loaded with the rails db:seed command (or created alongside the database with db:setup).
#
# Examples:
#
#   movies = Movie.create([{ name: 'Star Wars' }, { name: 'Lord of the Rings' }])
#   Character.create(name: 'Luke', movie: movies.first)

PaperTrail.request(whodunnit: "The Machine") do
  ActiveRecord::Base.transaction do
    Diet.create!([
      {name: "Diabetic"},
      {name: "GlutenFree"},
      {name: "Halal"},
      {name: "Hindu"},
      {name: "Kosher"},
      {name: "LowCalorie"},
      {name: "LowFat"},
      {name: "LowLactose"},
      {name: "LowSalt"},
      {name: "Vegan"},
      {name: "Vegetarian"}
    ])
    Allergy.create!([
      {name: "Cow's Milk"},
      {name: "Peanuts"},
      {name: "Eggs"},
      {name: "Shellfish"},
      {name: "Fish"},
      {name: "Tree Nuts"},
      {name: "Soy"},
      {name: "Wheat"},
      {name: "Rice"},
      {name: "Fruit"}
    ])
    PaymentType.create!([
      {name: "Cash"},
      {name: "Check"},
      {name: "Visa"},
      {name: "Discover Card"},
      {name: "Mastercard"},
      {name: "EBT/Foodstamps"},
      {name: "Giftcards"},
      {name: "Online Payments"},
      {name: "Bitcoin/Cryptocurrency"},
    ])

    if Rails.env.development?
      account = Account.create!(
        username: "krainboltgreene",
        name: "Kurtis Rainbolt-Greene",
        email: "kurtis@rainbolt-greene.online",
        password: "password",
      )
      account.convert!
      account.complete!
      account.spark!

      PaperTrail.request(whodunnit: account) do
        smokes_poutinerie = Establishment.create!(
          name: "Smoke's Poutinerie",
          google_places_id: "ChIJLbNPx9E0K4gRIpDVnhmgUb8",
          payment_types: [
            PaymentType.find_by(name: "Cash"),
            PaymentType.find_by(name: "Visa"),
            PaymentType.find_by(name: "Discover Card"),
            PaymentType.find_by(name: "Mastercard"),
            PaymentType.find_by(name: "Giftcards"),
          ]
        )

        traditional = smokes_poutinerie.menu_items.create!(
          name: "Traditional",
          description: "Smoke’s Signature Gravy, Québec Cheese Curd",
          allergies: [
            Allergy.find_by(name: "Eggs"),
            Allergy.find_by(name: "Cow's Milk")
          ]
        )
        traditional.publish!
        traditional.approve!

        veggie_traditional = smokes_poutinerie.menu_items.create!(
          name: "Veggie Traditional",
          description: "Smoke’s Veggie Gravy, Québec Cheese Curd",
          diets: [
            Diet.find_by(name: "Vegetarian")
          ],
          allergies: [
            Allergy.find_by(name: "Eggs"),
            Allergy.find_by(name: "Cow's Milk")
          ]
        )
        veggie_traditional.publish!
        veggie_traditional.approve!

        smokes_poutinerie.publish!
        smokes_poutinerie.approve!
      end
    end
  end
end
