defmodule Poutineer.Schema do
  use Absinthe.Schema

  import_types Absinthe.Type.Custom
  import_types Poutineer.Schema.Types.Account
  import_types Poutineer.Schema.Types.Allergy
  import_types Poutineer.Schema.Types.Answer
  import_types Poutineer.Schema.Types.Critique
  import_types Poutineer.Schema.Types.Diet
  import_types Poutineer.Schema.Types.Establishment
  import_types Poutineer.Schema.Types.MenuItem
  import_types Poutineer.Schema.Types.PaymentType
  import_types Poutineer.Schema.Types.Question
  import_types Poutineer.Schema.Types.Recipe
  import_types Poutineer.Schema.Types.Review
  import_types Poutineer.Schema.Types.Session
  import_types Poutineer.Schema.Types.Tag

  def middleware(middleware, _field, _object) do
    middleware ++ [Crudry.Middlewares.TranslateErrors]
  end

  query do
    @desc "Get all accounts"
    field :accounts, list_of(:account) do

      middleware &Poutineer.Schema.Middlewares.Sessions.require_authentication/2
      resolve &Poutineer.Schema.Resolvers.Accounts.list/3
    end

    @desc "Get an account by id"
    field :account, :account do
      arg :id, non_null(:id)

      middleware &Poutineer.Schema.Middlewares.Sessions.require_authentication/2
      resolve &Poutineer.Schema.Resolvers.Accounts.fetch/3
    end

    @desc "Get all allergies"
    field :allergies, list_of(:allergy) do
      resolve &Poutineer.Schema.Resolvers.Allergies.list/3
    end

    @desc "Get an allergy by id"
    field :allergy, :allergy do
      arg :id, non_null(:id)
      resolve &Poutineer.Schema.Resolvers.Allergies.fetch/3
    end

    @desc "Get all answers"
    field :answers, list_of(:answer) do
      resolve &Poutineer.Schema.Resolvers.Answers.list/3
    end

    @desc "Get an answer by id"
    field :answer, :answer do
      arg :id, non_null(:id)
      resolve &Poutineer.Schema.Resolvers.Answers.fetch/3
    end

    @desc "Get all critiques"
    field :critiques, list_of(:critique) do
      resolve &Poutineer.Schema.Resolvers.Critiques.list/3
    end

    @desc "Get an critique by id"
    field :critique, :critique do
      arg :id, non_null(:id)
      resolve &Poutineer.Schema.Resolvers.Critiques.fetch/3
    end

    @desc "Get all diets"
    field :diets, list_of(:diet) do
      resolve &Poutineer.Schema.Resolvers.Diets.list/3
    end

    @desc "Get an diet by id"
    field :diet, :diet do
      arg :id, non_null(:id)
      resolve &Poutineer.Schema.Resolvers.Diets.fetch/3
    end

    @desc "Get all establishments"
    field :establishments, list_of(:establishment) do
      resolve &Poutineer.Schema.Resolvers.Establishments.list/3
    end

    @desc "Get an establishment by id"
    field :establishment, :establishment do
      arg :id, non_null(:id)
      resolve &Poutineer.Schema.Resolvers.Establishments.fetch/3
    end

    @desc "Get all menu_items"
    field :menu_items, list_of(:menu_item) do
      resolve &Poutineer.Schema.Resolvers.MenuItems.list/3
    end

    @desc "Get an menu_item by id"
    field :menu_item, :menu_item do
      arg :id, non_null(:id)
      resolve &Poutineer.Schema.Resolvers.MenuItems.fetch/3
    end

    @desc "Get all payment_types"
    field :payment_types, list_of(:payment_type) do
      resolve &Poutineer.Schema.Resolvers.PaymentTypes.list/3
    end

    @desc "Get an payment_type by id"
    field :payment_type, :payment_type do
      arg :id, non_null(:id)
      resolve &Poutineer.Schema.Resolvers.PaymentTypes.fetch/3
    end

    @desc "Get all questions"
    field :questions, list_of(:question) do
      resolve &Poutineer.Schema.Resolvers.Questions.list/3
    end

    @desc "Get an question by id"
    field :question, :question do
      arg :id, non_null(:id)
      resolve &Poutineer.Schema.Resolvers.Questions.fetch/3
    end

    @desc "Get all recipes"
    field :recipes, list_of(:recipe) do
      resolve &Poutineer.Schema.Resolvers.Recipes.list/3
    end

    @desc "Get an recipe by id"
    field :recipe, :recipe do
      arg :id, non_null(:id)
      resolve &Poutineer.Schema.Resolvers.Recipes.fetch/3
    end

    @desc "Get all reviews"
    field :reviews, list_of(:review) do
      resolve &Poutineer.Schema.Resolvers.Reviews.list/3
    end

    @desc "Get an review by id"
    field :review, :review do
      arg :id, non_null(:id)
      resolve &Poutineer.Schema.Resolvers.Reviews.fetch/3
    end

    @desc "Get all tags"
    field :tags, list_of(:tag) do
      resolve &Poutineer.Schema.Resolvers.Tags.list/3
    end

    @desc "Get an tag by id"
    field :tag, :tag do
      arg :id, non_null(:id)
      resolve &Poutineer.Schema.Resolvers.Tags.fetch/3
    end
  end

  mutation do
    @desc "Create a new session with login credentials"
    field :create_session, :session do
      arg :email, non_null(:string)
      arg :password, non_null(:string)

      resolve &Poutineer.Schema.Resolvers.Sessions.create/3
      middleware &Poutineer.Schema.Middlewares.Sessions.update_session_id/2
    end

    field :create_account, :account do
      arg :name, :string
      arg :username, :string
      arg :email, non_null(:string)
      arg :password, :string

      resolve &Poutineer.Schema.Resolvers.Accounts.create/3
      middleware &Poutineer.Schema.Middlewares.Sessions.update_session_id/2
    end

    field :create_recipe, :recipe do
      arg :name, non_null(:string)
      arg :body, non_null(:string)
      arg :cook_time, non_null(:integer)
      arg :ingredients, non_null(list_of(:string))
      arg :instructions, non_null(list_of(:string))
      arg :prep_time, non_null(:integer)

      middleware &Poutineer.Schema.Middlewares.Sessions.require_authentication/2
      resolve &Poutineer.Schema.Resolvers.Recipes.create/3
    end

    field :assign_tag, non_null(:tag) do
      arg :name, non_null(:string)
      arg :subject_id, non_null(:id)
      arg :subject_type, non_null(:taggable_types)

      middleware &Poutineer.Schema.Middlewares.Sessions.require_authentication/2
      resolve &Poutineer.Schema.Resolvers.Tags.create/3
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
