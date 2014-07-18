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
      if defined?(Rails) && Rails.env.development?
        @group = 'Development'
        @uri = "http://#{ip}:#{port}" if port
      end
    end

    private

    def ip
      Socket.ip_address_list.find { |ai| ai.ipv4? && !ai.ipv4_loopback? }.ip_address
    end

    def port
      return Rails::Server.new.options[:Port] if defined?(Rails::Server)
      return ENV['PORT'] if ENV['PORT']
    end

  end
end
