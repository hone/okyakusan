module Okyakusan
  class Client
    def initialize(http)
      @http     = http
      netrc     = Netrc.read
      @username = netrc["api.heroku.com"].first
      @password = netrc["api.heroku.com"].last
    end

    %w(get delete).each do |method_name|
      define_method(method_name) do |path|
        klass   = Net::HTTP.const_get(method_name.capitalize)
        request = klass.new(path)

        setup_request(request)
        @http.request(request)
      end
    end

    %w(post patch).each do |method_name|
      define_method(method_name) do |path, data:|
        klass   = Net::HTTP.const_get(method_name.capitalize)
        request = klass.new(path)

        setup_request(request)
        request.body = data.to_json
        @http.request(request)
      end
    end

    private
    def setup_request(request)
      request.basic_auth(@username, @password)
      request.content_type = "application/json"
      request["Accept"]    = "application/vnd.heroku+json; version=3"
      request
    end
  end
end