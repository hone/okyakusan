require "sinatra/base"
require "json"

class HerokuHeader
  def initialize(app)
    @app = app
  end

  def call(env)
    if env["HTTP_ACCEPT"] == "application/vnd.heroku+json; version=3" &&
      env["CONTENT_TYPE"] == "application/json"
      @app.call(env)
    else
      ["500", {"Content-Type" => "text/plain" }, ["Header Mismatch"]]
    end
  end
end

class HerokuAPI < Sinatra::Base
  use HerokuHeader

  get "/apps/:app/env-vars" do
    <<OUTPUT
{
  "name": "FOO",
  "symbol": "laughing-fleetingly-1234:url",
  "value": "bar"
}
OUTPUT
  end

  delete "/apps/:app/addons/:addon" do
    <<OUTPUT
{
  "addon_service": {
    "id": "01234567-89ab-cdef-0123-456789abcdef",
    "name": "heroku-postgresql"
  },
  "config_vars": [
    "FOO",
    "BAZ"
  ],
  "created_at": "2012-01-01T12:00:00Z",
  "id": "01234567-89ab-cdef-0123-456789abcdef",
  "name": "heroku-postgresql-teal",
  "plan": {
    "id": "01234567-89ab-cdef-0123-456789abcdef",
    "name": "#{params[:addons]}"
  },
  "provider_id": "app123@heroku.com",
  "updated_at": "2012-01-01T12:00:00Z"
}
OUTPUT
  end

  post "/apps/:app/addons" do
    json = JSON.parse(request.body.read)
    <<OUTPUT
{
  "addon_service": {
    "id": "01234567-89ab-cdef-0123-456789abcdef",
    "name": "heroku-postgresql"
  },
  "config_vars": [
    "FOO",
    "BAZ"
  ],
  "created_at": "2012-01-01T12:00:00Z",
  "id": "01234567-89ab-cdef-0123-456789abcdef",
  "name": "heroku-postgresql-teal",
  "plan": {
    "id": "01234567-89ab-cdef-0123-456789abcdef",
    "name": "#{json["plan"]}"
  },
  "provider_id": "app123@heroku.com",
  "updated_at": "2012-01-01T12:00:00Z"
}
OUTPUT
  end

  patch "/apps/:app/addons/:addon" do
    json = JSON.parse(request.body.read)
    <<OUTPUT
{
  "addon_service": {
    "id": "01234567-89ab-cdef-0123-456789abcdef",
    "name": "heroku-postgresql"
  },
  "config_vars": [
    "FOO",
    "BAZ"
  ],
  "created_at": "2012-01-01T12:00:00Z",
  "id": "01234567-89ab-cdef-0123-456789abcdef",
  "name": "heroku-postgresql-teal",
  "plan": {
    "id": "#{json["plan"]}",
    "name": "#{params[:addon]}"
  },
  "provider_id": "app123@heroku.com",
  "updated_at": "2012-01-01T12:00:00Z"
}
OUTPUT
  end
end
