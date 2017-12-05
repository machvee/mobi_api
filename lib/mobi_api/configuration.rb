module MobiApi
  class Configuration
    DEFAULT_API_HOST = "http://api.lvh.me:3000"
    DEFAULT_VERSION = 1

    attr_accessor :host
    attr_accessor :api_key
    attr_accessor :version

    def initialize
      @host = DEFAULT_API_HOST
      @version = DEFAULT_VERSION
    end
  end
end
