namespace :db do
  task :replicate => :environment do
    include(Pundit)

    def current_account
      Account.first
    end

    def pundit_user
      current_account
    end

    def serialize_options
      {
        :meta => serialized_metadata,
        :links => serialized_links,
        :jsonapi => serialized_jsonapi,
        :namespace => ::V1
      }
    end

    def serialized_metadata
      {
        :api => {
          :version => "1"
        }
      }
    end

    def serialized_links
      {
        :discovery => {
          :href => ENV.fetch("DISCOVERY_ORIGIN")
        }
      }
    end

    def serialized_jsonapi
      {
        :version => "1.0"
      }
    end

    def default_context(default)
      {
        **default,
        **if respond_to?(:context) then context else {} end
      }
    end

    def serialize_models(models, fields, includes)
      JSONAPI::Serializer.serialize(
        models,
        **serialize_options,
        :fields => if fields.any? then fields end,
        :include => if includes.any? then includes end,
        :is_collection => true,
        :context => default_context(
          :policy_finder => method(:policy)
        )
      )
    end

    models = Account.all
    fields = {:accounts => ["name"]}
    includes = ["payments"]
    puts serialize_models(models, fields, includes)

    # require 'uri'
    # require 'net/http'
    #
    # url = URI("http://localhost:32792/blank-browser-react/accounts-1")
    #
    # http = Net::HTTP.new(url.host, url.port)
    #
    # request = Net::HTTP::Put.new(url)
    # request["content-type"] = 'application/json'
    # request["accept"] = 'application/json'
    # request.body = "{}"
    #
    # response = http.request(request)
    # puts response.read_body
  end
end
