## TODO


  - Copy over Procfile
  - Rewrite app.json description
  - Remove TODOs from readme
  - Setup heroku vars
  - Setup heroku addons
  - Rewrite script: BlankApiRails blank-api-rails blank_api_rails
  - Fix JSONAPI serializer relationship links
    ``` json
    "relationships": {
      "account": {
        "links": {
          "self": "/delivery-informations/b9ea82be-f15f-4623-8454-9119ced03940/relationships/account"
        },
        "data": {
          "type": "accounts",
          "id": "b1fe6783-425d-457c-9af8-a33afb2c149b"
        }
      },
    }
    ```
  - Fix bad parse error (`{"data":}`) payload to match jsonapi
  -

## Notes

### Making a new resource

  0. Create a route in `config/routes.rb`
  0. Create a controller in `app/controllers/{version}/{plural(name)}_controller.rb`
  0. Create a policy in `app/policies/{version}/{name}_policy.rb`
  0. Create a instance decorator in `app/decorators/{name}_decorator.rb`
  0. Create a collection decorator in `app/decorators/{plural(name)}_decorator.rb`
  0. Create a realizer in `app/realizers/{version}/{name}_realizer.rb`
  0. For each action allowed create a schema: `app/schemas/{version}/{plural(name)}/{action}_schema.rb`
  0. Create a serializer in `app/serializers/{version}/{name}_serializer.rb`
