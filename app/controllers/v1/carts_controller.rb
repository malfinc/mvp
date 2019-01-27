module V1
  class CartsController < ::V1::ApplicationController
    MODEL = ::Cart
    REALIZER = ::V1::CartRealizer
    MATERIALIZER = ::V1::CartMaterializer
    POLICY = CartPolicy

    def index
      render(
        :json => inline_jsonapi(
          :schema => ::V1::Carts::IndexSchema,
        ),
        :status => :ok
      )
    end

    def show
      render(
        :json => inline_jsonapi(
          :schema => ::V1::Carts::ShowSchema,
        ),
        :status => :ok
      )
    end

    def create
      render(
        :json => inline_jsonapi(
          :schema => ::V1::Carts::CreateSchema,
        ) { |model| model.save! },
        :status => :created
      )
    end

    def update
      render(
        :json => inline_jsonapi(
          :schema => ::V1::Carts::UpdateSchema,
        ) { |model| model.save! },
        :status => :ok
      )
    end
  end
end
