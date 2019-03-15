module V1
  class PaymentTypesController < ::V1::ApplicationController
    MODEL = ::PaymentType
    REALIZER = ::V1::PaymentTypeRealizer
    MATERIALIZER = ::V1::PaymentTypeMaterializer
    POLICY = PaymentTypePolicy

    def index
      render(
        :json => inline_jsonapi(
          :schema => ::V1::PaymentTypes::IndexSchema,
          :parameters => modified_parameters,
        ),
        :status => :ok,
      )
    end

    def show
      render(
        :json => inline_jsonapi(
          :schema => ::V1::PaymentTypes::ShowSchema,
          :parameters => modified_parameters,
        ),
        :status => :ok,
      )
    end
  end
end
