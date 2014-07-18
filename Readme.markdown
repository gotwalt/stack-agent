# StackAgent

A Rails agent for Stack. It'll automatically register your development stack when running locally.

# Configuration

Create a new rails initializer called `stack.rb`.
```ruby
StackAgent.configure do |c|
  c.app_token = 'YOUR_APP_TOKEN_HERE'
end

StackAgent.connect!
```
