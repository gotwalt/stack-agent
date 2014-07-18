require 'socket'

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
      @name = Socket.gethostname

      # If we're running inside rails, attempt to fill in a bunch of the blanks
      if defined?(Rails)
        # only do this if we're in development environment
        if Rails.env.development? && defined?(Rails::Server)
          ip = Socket.ip_address_list.find { |ai| ai.ipv4? && !ai.ipv4_loopback? }.ip_address
          port = Rails::Server.new.options[:Port]
          @uri = "http://#{ip}:#{port}"
          @group = 'Development'
        end

      end
    end

  end
end
