module V1
  class SearchMaterializer < ::V1::ApplicationMaterializer
    type(:searches)

    has(:results)
  end
end
