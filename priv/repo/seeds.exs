# Script for populating the database. You can run it as:
#
#     mix run priv/repo/seeds.exs
#
# Inside the script, you can read and write to any of your
# repositories directly:
#
#     Poutineer.Repo.insert!(%Poutineer.SomeSchema{})
#
# We recommend using the bang functions (`insert!`, `update!`
# and so on) as they will fail if something goes wrong.

Poutineer.Repo.insert_or_update!(Poutineer.Models.Diet.changeset(%Poutineer.Models.Diet{}, %{name: "Diabetic"}))
Poutineer.Repo.insert_or_update!(Poutineer.Models.Diet.changeset(%Poutineer.Models.Diet{}, %{name: "Gluten-Free"}))
Poutineer.Repo.insert_or_update!(Poutineer.Models.Diet.changeset(%Poutineer.Models.Diet{}, %{name: "Halal"}))
Poutineer.Repo.insert_or_update!(Poutineer.Models.Diet.changeset(%Poutineer.Models.Diet{}, %{name: "Hindu"}))
Poutineer.Repo.insert_or_update!(Poutineer.Models.Diet.changeset(%Poutineer.Models.Diet{}, %{name: "Kosher"}))
Poutineer.Repo.insert_or_update!(Poutineer.Models.Diet.changeset(%Poutineer.Models.Diet{}, %{name: "Low-Calorie"}))
Poutineer.Repo.insert_or_update!(Poutineer.Models.Diet.changeset(%Poutineer.Models.Diet{}, %{name: "Low-Fat"}))
Poutineer.Repo.insert_or_update!(Poutineer.Models.Diet.changeset(%Poutineer.Models.Diet{}, %{name: "Low-Lactose"}))
Poutineer.Repo.insert_or_update!(Poutineer.Models.Diet.changeset(%Poutineer.Models.Diet{}, %{name: "Low-Salt"}))
Poutineer.Repo.insert_or_update!(Poutineer.Models.Diet.changeset(%Poutineer.Models.Diet{}, %{name: "Vegan"}))
Poutineer.Repo.insert_or_update!(Poutineer.Models.Diet.changeset(%Poutineer.Models.Diet{}, %{name: "Vegetarian"}))

Poutineer.Repo.insert_or_update!(Poutineer.Models.Allergy.changeset(%Poutineer.Models.Allergy{}, %{name: "Cow's Milk"}))
Poutineer.Repo.insert_or_update!(Poutineer.Models.Allergy.changeset(%Poutineer.Models.Allergy{}, %{name: "Peanuts"}))
Poutineer.Repo.insert_or_update!(Poutineer.Models.Allergy.changeset(%Poutineer.Models.Allergy{}, %{name: "Eggs"}))
Poutineer.Repo.insert_or_update!(Poutineer.Models.Allergy.changeset(%Poutineer.Models.Allergy{}, %{name: "Shellfish"}))
Poutineer.Repo.insert_or_update!(Poutineer.Models.Allergy.changeset(%Poutineer.Models.Allergy{}, %{name: "Fish"}))
Poutineer.Repo.insert_or_update!(Poutineer.Models.Allergy.changeset(%Poutineer.Models.Allergy{}, %{name: "Tree Nuts"}))
Poutineer.Repo.insert_or_update!(Poutineer.Models.Allergy.changeset(%Poutineer.Models.Allergy{}, %{name: "Soy"}))
Poutineer.Repo.insert_or_update!(Poutineer.Models.Allergy.changeset(%Poutineer.Models.Allergy{}, %{name: "Wheat"}))
Poutineer.Repo.insert_or_update!(Poutineer.Models.Allergy.changeset(%Poutineer.Models.Allergy{}, %{name: "Rice"}))
Poutineer.Repo.insert_or_update!(Poutineer.Models.Allergy.changeset(%Poutineer.Models.Allergy{}, %{name: "Fruit"}))

Poutineer.Repo.insert_or_update!(Poutineer.Models.PaymentType.changeset(%Poutineer.Models.PaymentType{}, %{name: "Cash"}))
Poutineer.Repo.insert_or_update!(Poutineer.Models.PaymentType.changeset(%Poutineer.Models.PaymentType{}, %{name: "Check"}))
Poutineer.Repo.insert_or_update!(Poutineer.Models.PaymentType.changeset(%Poutineer.Models.PaymentType{}, %{name: "Visa"}))
Poutineer.Repo.insert_or_update!(Poutineer.Models.PaymentType.changeset(%Poutineer.Models.PaymentType{}, %{name: "Discover Card"}))
Poutineer.Repo.insert_or_update!(Poutineer.Models.PaymentType.changeset(%Poutineer.Models.PaymentType{}, %{name: "Mastercard"}))
Poutineer.Repo.insert_or_update!(Poutineer.Models.PaymentType.changeset(%Poutineer.Models.PaymentType{}, %{name: "EBT/Foodstamps"}))
Poutineer.Repo.insert_or_update!(Poutineer.Models.PaymentType.changeset(%Poutineer.Models.PaymentType{}, %{name: "Giftcards"}))
Poutineer.Repo.insert_or_update!(Poutineer.Models.PaymentType.changeset(%Poutineer.Models.PaymentType{}, %{name: "Online Payments"}))
Poutineer.Repo.insert_or_update!(Poutineer.Models.PaymentType.changeset(%Poutineer.Models.PaymentType{}, %{name: "Bitcoin/Cryptocurrency"}))

Poutineer.Repo.insert_or_update!(
  Poutineer.Models.Question.changeset(
    %Poutineer.Models.Question{},
    %{
      body: "Did the poutine have real cheese curds?",
      kind: "pick_one",
      answers: [
        Poutineer.Models.Answer.changeset(%Poutineer.Models.Answer{}, %{body: "Yes"}),
        Poutineer.Models.Answer.changeset(%Poutineer.Models.Answer{}, %{body: "No"}),
      ]
    }
  )
)

Poutineer.Repo.insert_or_update!(
  Poutineer.Models.Question.changeset(
    %Poutineer.Models.Question{},
    %{
      body: "Did the cheese curds squeak when bitten?",
      kind: "pick_one",
      answers: [
        Poutineer.Models.Answer.changeset(%Poutineer.Models.Answer{}, %{body: "Very sparse"}),
        Poutineer.Models.Answer.changeset(%Poutineer.Models.Answer{}, %{body: "A handful"}),
        Poutineer.Models.Answer.changeset(%Poutineer.Models.Answer{}, %{body: "A solid layer"}),
      ]
    }
  )
)
