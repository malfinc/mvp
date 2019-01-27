module V1
  class TagsController < ::V1::ApplicationController
    MODEL = ::Tag
    REALIZER = ::V1::TagRealizer
    MATERIALIZER = ::V1::TagMaterializer
    POLICY = TagPolicy

    def index
      render(
        :json => inline_jsonapi(
          :schema => ::V1::Tags::IndexSchema,
          :parameters => modified_parameters,
        ),
        :status => :ok
      )
    end

    def show
      render(
        :json => inline_jsonapi(
          :schema => ::V1::Tags::ShowSchema,
          :parameters => modified_parameters,
        ),
        :status => :ok
      )
    end

    def create
      render(
        :json => inline_jsonapi(
          :schema => ::V1::Tags::CreateSchema,
          :parameters => modified_parameters,
        ) {|model| model.save!},
        :status => :created
      )
    end
  end
end
