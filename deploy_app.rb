require 'rubygems'
require 'rack'
require 'json'
 
class DeployApp
  DEPLOY_DIR = File.expand_path(File.dirname(__FILE__))

  # Does what it says on the tin. By default, not much, it just prints the
  # received payload.
  def handle_request
    payload = @req.POST["payload"]

    return not_found if payload.nil?

    payload = JSON.parse(payload)

    %x{cd #{DEPLOY_DIR} && git pull && touch tmp/restart.txt}

    @res.write "Deploying in progress, check back later"
  end

  # Not Found response to non-postcommit requests
  def not_found
    @res.status = 404
    @res.write "nil => 404"
  end

  # Call is the entry point for all rack apps.
  def call(env)
    @req = Rack::Request.new(env)
    @res = Rack::Response.new
    handle_request
    @res.finish
  end
end
