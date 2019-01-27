module V1
  class SearchMaterializer < ::V1::ApplicationMaterializer
    type(:searches)

    has(:email, :visible => :readable_attribute?)
  end
end
