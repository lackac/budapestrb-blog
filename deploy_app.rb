require 'rubygems'
require 'rack'
require 'json'
 
class DeployApp
  # Does what it says on the tin. By default, not much, it just prints the
  # received payload.
  def handle_request
    payload = @req.POST["payload"]

    return "nil" if payload.nil?

    puts payload unless $TESTING # remove me!

    payload = JSON.parse(payload)

    # ... Your code goes here! ...

    @res.write "Deploying in progress, check back later"
  end

  # Call is the entry point for all rack apps.
  def call(env)
    @req = Rack::Request.new(env)
    @res = Rack::Response.new
    handle_request
    @res.finish
  end
end
