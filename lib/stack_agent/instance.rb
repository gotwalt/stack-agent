require 'json'

module StackAgent
  class Instance
    attr_accessor :instance_token

    def initialize(instance_token = nil)
      self.instance_token = instance_token
    end

    def register
      config = StackAgent.configuration

      return false unless config.app_token && config.name && config.uri

      url = "#{config.api_host}/v1/apps/#{config.app_token}/stacks"

      data = {
        group: config.group,
        name: config.name,
        uri: config.uri
      }

      begin
        response = RestClient::Resource.new(url, verify_ssl: OpenSSL::SSL::VERIFY_NONE).post(data)
        return self.instance_token = JSON.parse(response.body)['id']
      rescue RestClient::BadRequest => ex
        raise "Unable to register"
      end
    end

    def unregister
      raise 'Not registered' unless registered?

      config = StackAgent.configuration
      url = "#{config.api_host}/v1/apps/#{config.app_token}/stacks/#{instance_token}"

      begin
        RestClient::Resource.new(url, verify_ssl: OpenSSL::SSL::VERIFY_NONE).delete
        return true
      rescue RestClient::BadRequest => ex
        raise "Unable to unregister"
      end
    end

    def registered?
      instance_token != nil
    end
  end
end
