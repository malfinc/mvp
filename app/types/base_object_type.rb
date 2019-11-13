class BaseObjectType < GraphQL::Schema::Object
  field_class(BaseFieldType)
end
