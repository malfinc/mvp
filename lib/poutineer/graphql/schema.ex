defmodule Poutineer.Graphql.Schema do
  use Absinthe.Schema

  import_types Absinthe.Type.Custom
  import_types Poutineer.Graphql.Types.Account
  import_types Poutineer.Graphql.Types.Allergy
  import_types Poutineer.Graphql.Types.Answer
  import_types Poutineer.Graphql.Types.Critique
  import_types Poutineer.Graphql.Types.Diet
  import_types Poutineer.Graphql.Types.Establishment
  import_types Poutineer.Graphql.Types.MenuItem
  import_types Poutineer.Graphql.Types.PaymentType
  import_types Poutineer.Graphql.Types.Question
  import_types Poutineer.Graphql.Types.Recipe
  import_types Poutineer.Graphql.Types.Review
  import_types Poutineer.Graphql.Types.Session
  import_types Poutineer.Graphql.Types.Tag

  def middleware(middleware, _field, _object) do
    middleware ++ [Crudry.Middlewares.TranslateErrors]
  end

  query do
    @desc "Get all accounts"
    field :accounts, list_of(:account) do

      middleware &Poutineer.Graphql.Middlewares.Sessions.require_authentication/2
      resolve &Poutineer.Graphql.Resolvers.Accounts.list/3
    end

    @desc "Get an account by id"
    field :account, :account do
      arg :id, non_null(:id)

      middleware &Poutineer.Graphql.Middlewares.Sessions.require_authentication/2
      resolve &Poutineer.Graphql.Resolvers.Accounts.fetch/3
    end

    @desc "Get all allergies"
    field :allergies, list_of(:allergy) do
      resolve &Poutineer.Graphql.Resolvers.Allergies.list/3
    end

    @desc "Get an allergy by id"
    field :allergy, :allergy do
      arg :id, non_null(:id)
      resolve &Poutineer.Graphql.Resolvers.Allergies.fetch/3
    end

    @desc "Get all answers"
    field :answers, list_of(:answer) do
      resolve &Poutineer.Graphql.Resolvers.Answers.list/3
    end

    @desc "Get an answer by id"
    field :answer, :answer do
      arg :id, non_null(:id)
      resolve &Poutineer.Graphql.Resolvers.Answers.fetch/3
    end

    @desc "Get all critiques"
    field :critiques, list_of(:critique) do
      resolve &Poutineer.Graphql.Resolvers.Critiques.list/3
    end

    @desc "Get an critique by id"
    field :critique, :critique do
      arg :id, non_null(:id)
      resolve &Poutineer.Graphql.Resolvers.Critiques.fetch/3
    end

    @desc "Get all diets"
    field :diets, list_of(:diet) do
      resolve &Poutineer.Graphql.Resolvers.Diets.list/3
    end

    @desc "Get an diet by id"
    field :diet, :diet do
      arg :id, non_null(:id)
      resolve &Poutineer.Graphql.Resolvers.Diets.fetch/3
    end

    @desc "Get all establishments"
    field :establishments, list_of(:establishment) do
      resolve &Poutineer.Graphql.Resolvers.Establishments.list/3
    end

    @desc "Get an establishment by id"
    field :establishment, :establishment do
      arg :id, non_null(:id)
      resolve &Poutineer.Graphql.Resolvers.Establishments.fetch/3
    end

    @desc "Get all menu_items"
    field :menu_items, list_of(:menu_item) do
      resolve &Poutineer.Graphql.Resolvers.MenuItems.list/3
    end

    @desc "Get an menu_item by id"
    field :menu_item, :menu_item do
      arg :id, non_null(:id)
      resolve &Poutineer.Graphql.Resolvers.MenuItems.fetch/3
    end

    @desc "Get all payment_types"
    field :payment_types, list_of(:payment_type) do
      resolve &Poutineer.Graphql.Resolvers.PaymentTypes.list/3
    end

    @desc "Get an payment_type by id"
    field :payment_type, :payment_type do
      arg :id, non_null(:id)
      resolve &Poutineer.Graphql.Resolvers.PaymentTypes.fetch/3
    end

    @desc "Get all questions"
    field :questions, list_of(:question) do
      resolve &Poutineer.Graphql.Resolvers.Questions.list/3
    end

    @desc "Get an question by id"
    field :question, :question do
      arg :id, non_null(:id)
      resolve &Poutineer.Graphql.Resolvers.Questions.fetch/3
    end

    @desc "Get all recipes"
    field :recipes, list_of(:recipe) do
      resolve &Poutineer.Graphql.Resolvers.Recipes.list/3
    end

    @desc "Get an recipe by id"
    field :recipe, :recipe do
      arg :id, non_null(:id)
      resolve &Poutineer.Graphql.Resolvers.Recipes.fetch/3
    end

    @desc "Get all reviews"
    field :reviews, list_of(:review) do
      resolve &Poutineer.Graphql.Resolvers.Reviews.list/3
    end

    @desc "Get an review by id"
    field :review, :review do
      arg :id, non_null(:id)
      resolve &Poutineer.Graphql.Resolvers.Reviews.fetch/3
    end

    @desc "Get all tags"
    field :tags, list_of(:tag) do
      resolve &Poutineer.Graphql.Resolvers.Tags.list/3
    end

    @desc "Get an tag by id"
    field :tag, :tag do
      arg :id, non_null(:id)
      resolve &Poutineer.Graphql.Resolvers.Tags.fetch/3
    end
  end

  mutation do
    @desc "Create a new session with login credentials"
    field :create_session, :session do
      arg :email, non_null(:string)
      arg :password, non_null(:string)

      resolve &Poutineer.Graphql.Resolvers.Sessions.create/3
      middleware &Poutineer.Graphql.Middlewares.Sessions.update_session_id/2
    end

    field :destroy_session, :session do
      middleware &Poutineer.Graphql.Middlewares.Sessions.require_authentication/2
      resolve &Poutineer.Graphql.Resolvers.Sessions.create/3
      middleware &Poutineer.Graphql.Middlewares.Sessions.update_session_id/2
    end

    field :create_account, :account do
      arg :name, :string
      arg :username, :string
      arg :email, non_null(:string)
      arg :password, :string

      resolve &Poutineer.Graphql.Resolvers.Accounts.create/3
      middleware &Poutineer.Graphql.Middlewares.Sessions.update_session_id/2
    end

    field :grant_moderation_powers, :account do
      arg :account_id, non_null(:id)

      middleware &Poutineer.Graphql.Middlewares.Sessions.require_authentication/2
      resolve &Poutineer.Graphql.Resolvers.Accounts.grant_moderation_powers/3
    end

    field :grant_administration_powers, :account do
      arg :account_id, non_null(:id)

      middleware &Poutineer.Graphql.Middlewares.Sessions.require_authentication/2
      resolve &Poutineer.Graphql.Resolvers.Accounts.grant_administration_powers/3
    end

    field :create_recipe, :recipe do
      arg :name, non_null(:string)
      arg :body, non_null(:string)
      arg :cook_time, non_null(:integer)
      arg :ingredients, non_null(list_of(:string))
      arg :instructions, non_null(list_of(:string))
      arg :prep_time, non_null(:integer)

      middleware &Poutineer.Graphql.Middlewares.Sessions.require_authentication/2
      resolve &Poutineer.Graphql.Resolvers.Recipes.create/3
    end

    field :start_review, :review do
      arg :body, non_null(:string)

      middleware &Poutineer.Graphql.Middlewares.Sessions.require_authentication/2
      resolve &Poutineer.Graphql.Resolvers.Reviews.create/3
    end

    field :publish_review, :review do
      arg :review_id, non_null(:id)

      middleware &Poutineer.Graphql.Middlewares.Sessions.require_authentication/2
      resolve &Poutineer.Graphql.Resolvers.Moderations.publish/3
    end

    field :kill_review, :review do
      arg :review_id, non_null(:id)

      middleware &Poutineer.Graphql.Middlewares.Sessions.require_authentication/2
      resolve &Poutineer.Graphql.Resolvers.Moderations.kill/3
    end

    field :archive_review, :review do
      arg :review_id, non_null(:id)

      middleware &Poutineer.Graphql.Middlewares.Sessions.require_authentication/2
      resolve &Poutineer.Graphql.Resolvers.Moderations.archive/3
    end

    field :approve_review, :review do
      arg :review_id, non_null(:id)

      middleware &Poutineer.Graphql.Middlewares.Sessions.require_authentication/2
      resolve &Poutineer.Graphql.Resolvers.Moderations.approve/3
    end

    field :reject_review, :review do
      arg :review_id, non_null(:id)

      middleware &Poutineer.Graphql.Middlewares.Sessions.require_authentication/2
      resolve &Poutineer.Graphql.Resolvers.Moderations.reject/3
    end

    field :assign_tag, non_null(:tag) do
      arg :name, non_null(:string)
      arg :subject_id, non_null(:id)
      arg :subject_type, non_null(:taggable_types)

      middleware &Poutineer.Graphql.Middlewares.Sessions.require_authentication/2
      resolve &Poutineer.Graphql.Resolvers.Tags.create/3
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
