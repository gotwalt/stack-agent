require 'stack-agent/configuration'
require 'stack-agent/instance'

module StackAgent
  VERSION = '0.1.1'

  class << self
    attr_writer :configuration
  end

  def self.configuration
    @configuration ||= StackAgent::Configuration.new
  end

  def self.reset
    @configuration = StackAgent::Configuration.new
  end

  def self.configure
    yield(configuration)
  end

  def self.register
    @instance = StackAgent::Instance.new
    puts "Registered Stack #{@instance.instance_token}" if @instance.register
  end

  def self.unregister
    return false unless @instance
    puts "Unregistered Stack #{@instance.instance_token}" if @instance.unregister
  end

  def self.connect!
    register

    at_exit do
      unregister
    end
  end

end
