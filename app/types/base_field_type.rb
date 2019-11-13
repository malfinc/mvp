class BaseFieldType < GraphQL::Schema::Field
  argument_class(BaseArgumentType)

  def resolve_field(obj, args, ctx)
    resolve(obj, args, ctx)
  end
end
