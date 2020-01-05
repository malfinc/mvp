# Script for populating the database. You can run it as:
#
#     mix run priv/repo/seeds.exs
#
# Inside the script, you can read and write to any of your
# repositories directly:
#
#     Poutineer.Database.Repo.insert!(%Poutineer.SomeSchema{})
#
# We recommend using the bang functions (`insert!`, `update!`
# and so on) as they will fail if something goes wrong.

Enum.each([
  "Diabetic",
  "Gluten-Free",
  "Halal",
  "Hindu",
  "Kosher",
  "Low-Calorie",
  "Low-Fat",
  "Low-Lactose",
  "Low-Salt",
  "Vegan",
  "Vegetarian"
], fn name -> %Poutineer.Models.Diet{} |> Poutineer.Models.Diet.changeset(%{name: name}) |> Poutineer.Database.Repo.insert_or_update!() end)

Enum.each([
  "Cow's Milk",
  "Peanuts",
  "Eggs",
  "Shellfish",
  "Fish",
  "Tree Nuts",
  "Soy",
  "Wheat",
  "Rice",
  "Fruit"
], fn name -> %Poutineer.Models.Allergy{} |> Poutineer.Models.Allergy.changeset(%{name: name}) |> Poutineer.Database.Repo.insert_or_update!() end)

Enum.each([
  "Cash",
  "Check",
  "Visa",
  "Discover Card",
  "Mastercard",
  "EBT/Foodstamps",
  "Giftcards",
  "Online Payments",
  "Bitcoin/Cryptocurrency"
], fn name -> %Poutineer.Models.PaymentType{} |> Poutineer.Models.PaymentType.changeset(%{name: name}) |> Poutineer.Database.Repo.insert_or_update!() end)

Enum.each(
  [
    %{
      body: "What kind of fries did you eat?",
      kind: "pick_one",
      answers: [
        %{body: "Sweet Potato"},
        %{body: "Steak"},
        %{body: "Shoestring"},
        %{body: "Curly"},
        %{body: "Classic Cut"},
        %{body: "Wedge Cut"},
        %{body: "Slap Chips"},
        %{body: "Tornado"},
        %{body: "Waffle Cut"},
        %{body: "Crinkle Cut"}
      ]
    },
    %{
      body: "How was the cheese prepared?",
      kind: "pick_one",
      answers: [
        %{
          body: "Curds",
          questions: [
            %{
              body: "How many cheese curds were there?",
              kind: "pick_one",
              answers: [
                %{body: "Very sparse"},
                %{body: "A handful"},
                %{body: "A solid layer"}
              ]
            },
            %{
              body: "Did the cheese curds squeak when bitten?",
              kind: "pick_one",
              answers: [
                %{body: "Yes"},
                %{body: "No"}
              ]
            }
          ]
        },
        %{body: "Shredded"},
        %{body: "Sliced"}
      ]
    },
    %{
      body: "Was the cheese Dairy or Vegan?",
      kind: "pick_one",
      answers: [
        %{body: "Dairy"},
        %{body: "Vegan"}
      ]
    }
  ],
  fn question -> %Poutineer.Models.Question{} |> Poutineer.Models.Question.changeset(question) |> Poutineer.Database.Repo.insert_or_update!() end
)

Enum.each(
  [
    %{
      name: "Smoke's Poutinerie",
      google_place_id: "ChIJLbNPx9E0K4gRIpDVnhmgUb8",
      menu_items: [
        %{
          name: "Traditional",
          body: "Smoke’s Signature Gravy, Québec Cheese Curd",
        }
      ]
    }
  ],
  fn establishment -> %Poutineer.Models.Establishment{} |> Poutineer.Models.Establishment.changeset(establishment) |> Poutineer.Database.Repo.insert_or_update!() end
)
