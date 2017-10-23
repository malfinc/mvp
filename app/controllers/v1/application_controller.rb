module V1
  class ApplicationController < ::ApplicationController
    include JSONAPI::ActsAsResourceController
  end
end
