# BlankApiRails

## Notes

### Making a new resource

  0. Create a route in `config/routes.rb`
  0. Create a controller in `app/controllers/{version}/{plural(name)}_controller.rb`
  0. Create a instance decorator in `app/decorators/{name}_decorator.rb`
  0. Create a collection decorator in `app/decorators/{plural(name)}_decorator.rb`
  0. Create a materalizer in `app/materializers/{version}/{name}_materializer.rb`
  0. Create a policy in `app/policies/{version}/{name}_policy.rb`
    0. Define a `{attribute}_readable?` for every attribute and relationship on the materializer
  0. Create a realizer in `app/realizers/{version}/{name}_realizer.rb`
  0. For each action allowed create a schema: `app/schemas/{version}/{plural(name)}/{action}_schema.rb`
