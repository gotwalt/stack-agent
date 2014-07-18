module StackAgent
  class Configuration
    DEFAULT_API_HOST = 'https://stackotron-discover.herokuapp.com'

    attr_accessor :api_host
    attr_accessor :app_token
    attr_accessor :name
    attr_accessor :group
    attr_accessor :uri

    def initialize
      @api_host = DEFAULT_API_HOST
    end

  end
end
