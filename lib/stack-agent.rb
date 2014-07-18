require 'stack-agent/configuration'
require 'stack-agent/instance'

module StackAgent
  VERSION = '0.1.0'

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
    @instance.register
  end

  def self.unregister
    raise 'Not registered' unless @instance && @instance.registered?
    @instance.unregister
  end

  def self.connect!
    register

    at_exit do
      unregister
    end
  end

end