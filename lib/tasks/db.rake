namespace :db do
  task :replicate => :environment do
    include(Pundit)

    def current_account
      Account.first
    end

    def pundit_user
      current_account
    end

    models = Account.all
    fields = {:accounts => ["name"]}
    includes = ["payments"]
    puts serialize(models, fields, includes)

    # require 'uri'
    # require 'net/http'
    #
    # url = URI("http://localhost:32792/poutineer/accounts-1")
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
