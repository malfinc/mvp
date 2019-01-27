module V1
  class TagMaterializer < ::V1::ApplicationMaterializer
    type(:tags)

    has(:name, :visible => :readable_attribute?)
  end
end
