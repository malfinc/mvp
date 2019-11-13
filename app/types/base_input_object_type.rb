class BaseInputObjectType < GraphQL::Schema::InputObject
  argument_class(BaseArgumentType)
end
