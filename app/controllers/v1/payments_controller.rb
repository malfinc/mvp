module V1
  class PaymentsController < ::V1::ApplicationController
    MODEL = ::Payment
    REALIZER = ::V1::PaymentRealizer
    MATERIALIZER = ::V1::PaymentMaterializer
    POLICY = PaymentPolicy

    def index
      render(
        :json => inline_jsonapi(
          :schema => ::V1::Payments::IndexSchema,
          :parameters => modified_parameters,
        ),
        :status => :ok
      )
    end

    def show
      render(
        :json => inline_jsonapi(
          :schema => ::V1::Payments::ShowSchema,
          :parameters => modified_parameters,
        ),
        :status => :ok
      )
    end

    def create
      render(
        :json => inline_jsonapi(
          :schema => ::V1::Payments::CreateSchema,
          :parameters => modified_parameters,
        ) {|model| model.save!},
        :status => :created
      )
    end
  end
end
