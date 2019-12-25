defmodule Poutineer.Schema do
  use Absinthe.Schema
  import_types Poutineer.Schema.Types

  alias Poutineer.Resolvers
  def middleware(middleware, _field, _object) do
    middleware ++ [Crudry.Middlewares.TranslateErrors]
  end

  query do
    @desc "Get all accounts"
    field :accounts, list_of(:account) do
      resolve &Resolvers.Accounts.list/3
    end

    @desc "Get an account by id"
    field :account, :account do
      arg :id, non_null(:id)
      resolve &Resolvers.Accounts.fetch/3
    end

    @desc "Get all allergies"
    field :allergies, list_of(:allergy) do
      resolve &Resolvers.Allergies.list/3
    end

    @desc "Get an allergy by id"
    field :allergy, :allergy do
      arg :id, non_null(:id)
      resolve &Resolvers.Allergies.fetch/3
    end

    @desc "Get all answers"
    field :answers, list_of(:answer) do
      resolve &Resolvers.Answers.list/3
    end

    @desc "Get an answer by id"
    field :answer, :answer do
      arg :id, non_null(:id)
      resolve &Resolvers.Answers.fetch/3
    end

    @desc "Get all critiques"
    field :critiques, list_of(:critique) do
      resolve &Resolvers.Critiques.list/3
    end

    @desc "Get an critique by id"
    field :critique, :critique do
      arg :id, non_null(:id)
      resolve &Resolvers.Critiques.fetch/3
    end

    @desc "Get all diets"
    field :diets, list_of(:diet) do
      resolve &Resolvers.Diets.list/3
    end

    @desc "Get an diet by id"
    field :diet, :diet do
      arg :id, non_null(:id)
      resolve &Resolvers.Diets.fetch/3
    end

    @desc "Get all establishments"
    field :establishments, list_of(:establishment) do
      resolve &Resolvers.Establishments.list/3
    end

    @desc "Get an establishment by id"
    field :establishment, :establishment do
      arg :id, non_null(:id)
      resolve &Resolvers.Establishments.fetch/3
    end

    @desc "Get all menu_items"
    field :menu_items, list_of(:menu_item) do
      resolve &Resolvers.MenuItems.list/3
    end

    @desc "Get an menu_item by id"
    field :menu_item, :menu_item do
      arg :id, non_null(:id)
      resolve &Resolvers.MenuItems.fetch/3
    end

    @desc "Get all payment_types"
    field :payment_types, list_of(:payment_type) do
      resolve &Resolvers.PaymentTypes.list/3
    end

    @desc "Get an payment_type by id"
    field :payment_type, :payment_type do
      arg :id, non_null(:id)
      resolve &Resolvers.PaymentTypes.fetch/3
    end

    @desc "Get all questions"
    field :questions, list_of(:question) do
      resolve &Resolvers.Questions.list/3
    end

    @desc "Get an question by id"
    field :question, :question do
      arg :id, non_null(:id)
      resolve &Resolvers.Questions.fetch/3
    end

    @desc "Get all recipes"
    field :recipes, list_of(:recipe) do
      resolve &Resolvers.Recipes.list/3
    end

    @desc "Get an recipe by id"
    field :recipe, :recipe do
      arg :id, non_null(:id)
      resolve &Resolvers.Recipes.fetch/3
    end

    @desc "Get all reviews"
    field :reviews, list_of(:review) do
      resolve &Resolvers.Reviews.list/3
    end

    @desc "Get an review by id"
    field :review, :review do
      arg :id, non_null(:id)
      resolve &Resolvers.Reviews.fetch/3
    end

    @desc "Get all tags"
    field :tags, list_of(:tag) do
      resolve &Resolvers.Tags.list/3
    end

    @desc "Get an tag by id"
    field :tag, :tag do
      arg :id, non_null(:id)
      resolve &Resolvers.Tags.fetch/3
    end
  end

  mutation do
    field :create_account, :account do
      arg :name, :string
      arg :username, :string
      arg :email, non_null(:string)
      arg :password, :string

      resolve &Resolvers.Accounts.create/3
    end

    field :create_recipe, :recipe do
      arg :name, non_null(:string)
      arg :body, non_null(:string)
      arg :cook_time, non_null(:integer)
      arg :ingredients, non_null(list_of(:string))
      arg :instructions, non_null(list_of(:string))
      arg :prep_time, non_null(:integer)

      resolve &Resolvers.Recipes.create/3
    end
  end

  subscription do
    field :account_created, :account do
      arg :id, non_null(:id)

      # The topic function is used to determine what topic a given subscription
      # cares about based on its arguments.
      config fn args, _ ->
        {:ok, topic: args.id}
      end

      # This tells Absinthe to run any subscriptions with this field every time
      # the mutation happens. It also has a topic function used to find what
      # subscriptions care about this particular comment.
      trigger :create_account, topic: fn account ->
        account.id
      end
    end
  end
end
