require 'json'
require 'rest-client'

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
        false
      end
    end

    def unregister
      return false unless registered?

      config = StackAgent.configuration
      url = "#{config.api_host}/v1/apps/#{config.app_token}/stacks/#{instance_token}"

      begin
        RestClient::Resource.new(url, verify_ssl: OpenSSL::SSL::VERIFY_NONE).delete
        true
      rescue RestClient::BadRequest => ex
        false
      end
    end

    def registered?
      instance_token != nil
    end

    def self.stacks
      config = StackAgent.configuration
      url = "#{config.api_host}/v1/apps/#{config.app_token}/stacks"
      response = RestClient::Resource.new(url, verify_ssl: OpenSSL::SSL::VERIFY_NONE).get
      JSON.parse(response.body)
    end
  end
end
