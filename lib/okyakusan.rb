require "okyakusan/version"
require "okyakusan/client"
require "uri"
require "net/http"

module Okyakusan
  def self.start(base = "https://api.heroku.com", sudo = false)
    uri = URI(base)
    Net::HTTP.start(uri.hostname, uri.port, use_ssl: uri.scheme == 'https') do |http|
      client = Client.new(http, sudo)
      yield(client)
    end
  end
end
