module V1
  class TagMaterializer < ::V1::ApplicationMaterializer
    type(:tags)

    has(:name)
  end
end
