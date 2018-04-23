TODO:

  - Remove support for `me` slugs
  - "errors" => [{"source"=>{"pointer"=>"/data/attributes/account"}, "detail"=>"Account must exist"}],
  -   12) shipping-informations POST /v1/shipping-informations with a fresh cart and a signed-in account returns CREATED
      Failure/Error: expect(response).to have_http_status(:created)
        expected the response to have status code :created (201) but it was :unprocessable_entity (422)
      # ./spec/requests/shipping_informations_spec.rb:32:in `block (4 levels) in <top (required)>'
