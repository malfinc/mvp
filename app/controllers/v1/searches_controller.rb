module V1
  class SearchesController < ::V1::ApplicationController
    MODEL = ::Search
    REALIZER = ::V1::SearchRealizer
    MATERIALIZER = ::V1::SearchMaterializer
    POLICY = SearchPolicy

    def index
      render(
        :json => inline_jsonapi(
          :schema => ::V1::Searches::IndexSchema,
          :parameters => modified_parameters,
        ),
        :status => :ok
      )
    end

    def show
      render(
        :json => inline_jsonapi(
          :schema => ::V1::Searches::ShowSchema,
          :parameters => modified_parameters,
        ),
        :status => :ok
      )
    end

    def create
      render(
        :json => inline_jsonapi(
          :schema => ::V1::Searches::CreateSchema,
          :parameters => modified_parameters,
        ) {|model| model.save!},
        :status => :created
      )
    end
  end
end
