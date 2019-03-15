# This file should contain all the record creation needed to seed the database with its default values.
# The data can then be loaded with the rails db:seed command (or created alongside the database with db:setup).
#
# Examples:
#
#   movies = Movie.create([{ name: "Star Wars" }, { name: "Lord of the Rings" }])
#   Character.create(name: "Luke", movie: movies.first)

PaperTrail.request(:whodunnit => Account::MACHINE_EMAIL, :controller_info => {:context_id => SecureRandom.uuid(), :actor_id => Account::MACHINE_ID}) do
  ActiveRecord::Base.transaction do
    Diet.create([
      {:name => "Diabetic"},
      {:name => "GlutenFree"},
      {:name => "Halal"},
      {:name => "Hindu"},
      {:name => "Kosher"},
      {:name => "LowCalorie"},
      {:name => "LowFat"},
      {:name => "LowLactose"},
      {:name => "LowSalt"},
      {:name => "Vegan"},
      {:name => "Vegetarian"},
    ])
    Allergy.create([
      {:name => "Cow's Milk"},
      {:name => "Peanuts"},
      {:name => "Eggs"},
      {:name => "Shellfish"},
      {:name => "Fish"},
      {:name => "Tree Nuts"},
      {:name => "Soy"},
      {:name => "Wheat"},
      {:name => "Rice"},
      {:name => "Fruit"},
    ])
    PaymentType.create([
      {:name => "Cash"},
      {:name => "Check"},
      {:name => "Visa"},
      {:name => "Discover Card"},
      {:name => "Mastercard"},
      {:name => "EBT/Foodstamps"},
      {:name => "Giftcards"},
      {:name => "Online Payments"},
      {:name => "Bitcoin/Cryptocurrency"},
    ])

    Question.create!(:body => "Did the poutine have real cheese curds?", :kind => "pick_one").tap do |question|
      question.answers.create!([
        {:body => "Yes"},
        {:body => "No"},
      ])
    end
    Question.create!(:body => "Did the cheese curds squeak when bitten?", :kind => "pick_one").tap do |question|
      question.answers.create!([
        {:body => "Very sparse"},
        {:body => "A handful"},
        {:body => "A solid layer"},
      ])
    end

    if Rails.env.development? && ENV.key?("BENCHMARK")
      1000.times.each do
        FactoryBot.create(
          :account,
          *[
            *15.times.map {[]},
            *25.times.map {[:confirmed]},
            *45.times.map {[:confirmed, :completed]},
            *5.times.map {[:confirmed, :completed, :administrator]},
          ].sample,
        )
      end
    end

    # Setting up different types of accounts
    if Rails.env.production? && Account.count.zero?
      krainboltgreene = Account.create!(
        :username => "krainboltgreene",
        :name => "Kurtis Rainbolt-Greene",
        :email => "kurtis@rainbolt-greene.online",
        :password => SecureRandom.hex(32),
      )
      krainboltgreene.confirm
      krainboltgreene.complete!
      krainboltgreene.upgrade_to_administrator!
    end

    if Rails.env.development?
      administrator = Account.create!(
        :username => "sally",
        :name => "Sally Stuthers",
        :email => "sally@example.com",
        :password => "password",
      )
      administrator.confirm
      administrator.complete!
      administrator.upgrade_to_administrator!

      moderator = Account.create!(
        :username => "mark",
        :name => "Mark Muffalo",
        :email => "mark@example.com",
        :password => "password",
      )
      moderator.confirm
      moderator.complete!
      moderator.empower!

      user = Account.create!(
        :username => "calvin",
        :name => "Calvin Klean",
        :email => "calvin@example.com",
        :password => "password",
      )
      user.confirm
      user.complete!

      PaperTrail.request(:whodunnit => administrator.email, :controller_info => {:context_id => SecureRandom.uuid(), :actor_id => administrator.id}) do
        smokes_poutinerie = Establishment.create!(
          :name => "Smoke's Poutinerie",
          :google_places_id => "ChIJLbNPx9E0K4gRIpDVnhmgUb8",
          :payment_types => [
            PaymentType.find_by(:name => "Cash"),
            PaymentType.find_by(:name => "Visa"),
            PaymentType.find_by(:name => "Discover Card"),
            PaymentType.find_by(:name => "Mastercard"),
            PaymentType.find_by(:name => "Giftcards"),
          ],
          :google_place => {
            "types" => ["restaurant", "food", "point_of_interest", "establishment"],
            "photos" => [
              "https://lh3.googleusercontent.com/p/AF1QipP2zr_6z7J6FxzJpCvmWXrPxp3-0DViRTehY-su=s1600-w512",
              "https://lh3.googleusercontent.com/p/AF1QipNwRQFLfPTXF-eOHTXOg1ytpsqdTFOxuwg5JDSN=s1600-w512",
              "https://lh3.googleusercontent.com/p/AF1QipNjZiUMTQu6V0O2t8tjUoxSrfOE18JyBx4WANdR=s1600-w512",
            ],
            "rating" => 4.1,
            "address" => "218 Adelaide St W, Toronto, ON M5H 1W7, Canada",
            "website" => "http://smokespoutinerie.com/",
            "phone_number" => "(416) 599-2873",
            "schedule" => [
              {"open" => {"day" => 0, "time" => "1100"}, "close" => {"day" => 1, "time" => "0000"}},
              {"open" => {"day" => 1, "time" => "1100"}, "close" => {"day" => 2, "time" => "0000"}},
              {"open" => {"day" => 2, "time" => "1100"}, "close" => {"day" => 3, "time" => "0000"}},
              {"open" => {"day" => 3, "time" => "1100"}, "close" => {"day" => 4, "time" => "0300"}},
              {"open" => {"day" => 4, "time" => "1100"}, "close" => {"day" => 5, "time" => "0300"}},
              {"open" => {"day" => 5, "time" => "1100"}, "close" => {"day" => 6, "time" => "0400"}},
              {"open" => {"day" => 6, "time" => "1100"}, "close" => {"day" => 0, "time" => "0400"}},
            ],
          },
        )

        traditional = smokes_poutinerie.menu_items.create!(
          :name => "Traditional",
          :description => "Smoke’s Signature Gravy, Québec Cheese Curd",
          :allergies => [
            Allergy.find_by(:name => "Eggs"),
            Allergy.find_by(:name => "Cow's Milk"),
          ],
        )
        traditional.publish!
        traditional.approve!

        veggie_traditional = smokes_poutinerie.menu_items.create!(
          :name => "Veggie Traditional",
          :description => "Smoke’s Veggie Gravy, Québec Cheese Curd",
          :diets => [
            Diet.find_by(:name => "Vegetarian"),
          ],
          :allergies => [
            Allergy.find_by(:name => "Eggs"),
            Allergy.find_by(:name => "Cow's Milk"),
          ],
        )
        veggie_traditional.publish!
        veggie_traditional.approve!

        smokes_poutinerie.publish!
        smokes_poutinerie.approve!

        vegan_recipe_description = <<~DESCRIPTION
          Vegan poutine with crispy potatoes, savory mushroom gravy, and melty vegan cheese curds! The perfect plant-based alternative to this Canadian classic.
           Notes:
             * FRIES: If avoiding oil, first steam your potatoes in a large steamer basket (covered) until almost tender - about 10 minutes. Then arrange on parchment-lined baking sheets and season with salt. Bake at 400 degrees F (204 C) until slightly golden brown - about 15 minutes. The fries won’t be as crispy, but they'll still be delicious.
            * GRAVY: For more flavor, other additions might include a little nutritional yeast and/or maple syrup.
            * Based on my research, ketchup seemed to be a fairly common addition to poutine gravy. However, the idea of ketchup in gravy weirded me out. I tried it and didn’t like it. I found balsamic vinegar, coconut aminos, and a touch of Worcestershire to strike a good flavor balance.
            * CHEESE: If you have leftover cheese, it can be used on things like sandwiches, caprese salads, pasta bakes, breadsticks, or pizza!
            * Nutrition information is a rough estimate for 1 of 6 servings with all of the suggested oil, all of the gravy, and all of the vegan cheese.
        DESCRIPTION
        author.recipes.create!(
          :name => "An amazing vegan poutine",
          :description => vegan_recipe_description,
          :ingredients => [
            "4 russet potatoes (~800 g) , unpeeled (or sub sweet potatoes for a savory-sweet poutine!)",
            "3-4 Tbsp (45-60 ml) avocado or melted coconut oil (if avoiding oil, see notes)",
            "1/2 tsp sea salt",
            "3 Tbsp (45 g) avocado or melted coconut oil (if avoiding oil, sub water)",
            "2 shallots (50 g), minced",
            "1 1/2 cups (105 g) diced button or cremini mushrooms",
            "1/4 tsp each sea salt and black pepper, plus more to taste",
            "1 Tbsp (15 ml) balsamic vinegar",
            "optional: 1 tsp coconut aminos",
            "3 Tbsp (21 g) cornstarch (or arrowroot // if not GF, sub all-purpose flour)",
            "1/2 cup (120 ml) vegetable broth (DIY or store-bought)",
            "1 cup (240 ml) unsweetened plain almond milk",
            "optional: 1-2 tsp vegan worcestershire sauce or ketchup* (such as Annie’s brand, which isn’t GF)",
            "1 batch Easy Vegan Mozzarella “Cheese”, separated into 1 tsp amounts (which act as “cheese curds” // or sub 1 cup store-bought vegan mozzarella cheese)*",
          ],
          :instructions => [
            "FRIES: Preheat oven to 450 degrees F (232 C) and chop potatoes into thin slices by halving lengthwise then cutting into wedges and then strips. For “wedges,” cut into larger pieces - both work the same, but matchsticks cook faster.",
            "Line two large baking sheets with parchment paper. Add fries, oil (see notes for substitution), and salt and toss to coat. Then arrange fries in a single layer, making sure they aren’t overlapping too much. This will help them crisp up and cook evenly.",
            "Bake for a total of 25-35 minutes, tossing/flipping at least once to ensure even baking. When the fries are finished, remove from oven and set aside.",
            "GRAVY: While fries are baking, prepare gravy by heating a rimmed skillet over medium heat. Once hot, add oil (or water) and shallots. Sauté for 2-3 minutes, stirring occasionally. Then add mushrooms, salt, pepper, balsamic vinegar, and coconut aminos (optional).",
            "Stir and increase heat to medium high to brown the mushrooms. Cook for 4-5 minutes or until they are slightly caramelized. Then add the cornstarch and stir to coat. It should look dry at this point - that’s OK.",
            "Lower heat to low and slowly add the broth and almond milk while whisking. It should resemble gravy pretty quickly and should bubble and thicken as it cooks.",
            "Cook for 4-5 minutes, or until you've reached the desired consistency. Add broth or almond milk to thin if it becomes too thick.",
            "Transfer to a blender and blend until smooth (optional but recommended). Taste and adjust flavor as needed, adding more salt and pepper to taste or more Worcestershire or coconut aminos for more depth of flavor. See notes for other additions if you desire more depth of flavor.",
            "Return gravy to stovetop and heat on lowest heat to keep warm.",
            "FOR SERVING: Add all of the baked fries to one baking sheet. Then divide the Vegan Mozzarella Cheese into 1 tsp \"curds\" and add to the baked fries (I used just shy of 1 batch of the recipe). Then place fries back in oven on the top rack on medium-to-low broil so the cheese can melt and get slightly browned. Watch carefully so the fries don't burn - 3-5 minutes.",
            "Pour the gravy over top and dig in! This is a dish best enjoyed fresh! However, the cheese will store separately in the fridge up to 10 days (see notes for other uses). The gravy will keep in the refrigerator up to 5 days (reheat on stovetop for best results - add more almond milk or broth to thin if thickened), and the fries will store for 2-3 days (reheat in oven at 350 degrees F (176 C) for best results).",
          ],
          :diets => [
            Diet.find_by(:name => "GlutenFree"),
            Diet.find_by(:name => "Vegan"),
          ],
          :cook_time => 45,
          :prep_time => 15,
        )
      end
    end
  end
end
