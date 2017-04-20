require "mobi_api/version"
require "mobi_api/configuration"
require 'json_api_client'

module MobiApi
  class << self
    attr_writer :configuration
  end

  def self.configuration
    @configuration ||= Configuration.new
  end

  def self.reset
    @configuration = Configuration.new
  end

  def self.configure
    yield(configuration)
  end

  class MobiApiKey < Faraday::Middleware
    X_API_KEY = 'X-Api-Key'.freeze

    def call(env)
      env[:request_headers][X_API_KEY] = MobiApi.configuration.api_key
      @app.call(env)
    end
  end

  class MobiApiAuth < Faraday::Middleware
    AUTHORIZATION = 'Authorization'.freeze

    def initialize(app=nil, tokenizer)
      @token = tokenizer
      super(app)
    end

    def call(env)
      env[:request_headers][AUTHORIZATION] = @token[:auth_token] if @token.has_key?(:auth_token)
      @app.call(env)
    end
  end

  class Base < JsonApiClient::Resource
    @tokenizer = {}
    self.site = format("%s/v%d", MobiApi.configuration.host, MobiApi.configuration.version)
    self.connection do |conn|
      conn.use MobiApiKey
      conn.use MobiApiAuth, @tokenizer
    end

    def self.set_auth_token(auth_token)
      @tokenizer[:auth_token] = auth_token
    end
  end


  class Session < Base
  end

  class Location < Base
  end

  class Account < Base
  end

  class User < Base
  end

  class Profile < Base
  end

  class Merchant < Base
  end

  class Apps < Base
  end

  class NearbyMerchant < Base
  end

  class Event < Base
    belongs_to :merchant
  end

  class Participant < Base
    belongs_to :event
  end

  class UserCheckin < Base
  end

  class MerchantCheckin < Base
    def self.table_name
      "checkins"
    end

    belongs_to :merchant
  end
end