module V1
  class TagsController < ::V1::ApplicationController
    discoverable(
      :version => "v1",
      :namespace => "tags"
    )

    def index
      authorize(policy_scope(Tag))

      realization = JSONAPI::Realizer.index(
        Tags::IndexSchema.new(request.parameters),
        :headers => request.headers,
        :scope => policy_scope(Tag),
        :type => :accounts
      )

      render(:json => serialize(realization))
    end

    def show
      realization = JSONAPI::Realizer.show(
        Tags::ShowSchema.new(request.parameters),
        :headers => request.headers,
        :scope => policy_scope(Tag),
        :type => :accounts
      )

      authorize(realization.model)

      return unless stale?(:etag => realization.model)

      render(:json => serialize(realization))
    end
  end
end
