require 'thor'
require 'stack-agent'
require 'irb'

module StackAgent
  class Cli < Thor
    desc 'register APP_TOKEN', 'Registers this instance against the provided token'
    def register(app_token = nil, name = nil, uri = nil)

      StackAgent.configure do |c|
        c.app_token = app_token
        c.name = name
        c.uri = uri
      end

      if id = StackAgent::Instance.new().register
        puts "Registered as stack #{id}"
      end
    end

    desc 'unregister APP_TOKEN INSTANCE_TOKEN', 'Unregisters the provided app and instance token'
    def unregister(app_token, instance_token)
      StackAgent.configure do |c|
        c.app_token = app_token
      end

      StackAgent::Instance.new(instance_token).unregister
      puts "Unregistered stack"
    end

    desc 'stacks APP_TOKEN', 'Lists known stacks for a given app'
    def stacks(app_token)
      StackAgent.configure do |c|
        c.app_token = app_token
      end

      stacks = StackAgent::Instance.stacks

      puts "Stacks"
      stacks.each do |stack|
        puts "#{stack['id'].ljust(30)} #{stack['name'].ljust(30)} #{stack['uri']}"
      end
    end

    desc 'cli', 'Launches IRB instance with everything required'
    def cli
      ARGV.clear
      IRB.start
    end

  end
end
