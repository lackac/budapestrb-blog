require 'rubygems'
require 'rack'
require 'json'
 
class DeployApp
  DEPLOY_DIR = File.expand_path(File.dirname(__FILE__))
  SEMAFOR = File.join(DEPLOY_DIR, ".deploying")

  # Does what it says on the tin. By default, not much, it just prints the
  # received payload.
  def handle_request
    return not_found unless request_is_ok?

    payload = JSON.parse(@req.POST["payload"])

    FileUtils.touch(SEMAFOR)
    deploy
    FileUtils.rm(SEMAFOR)
    @res.write "Deploying in progress, check back later"
  end

  # Is it a correct request and aren't we deploying already
  def request_is_ok?
    if @req.POST["payload"].nil?
      false
    elsif @req.path_info != '/deploy'
      puts "DeployApp: POST with payload but not to '/deploy'"
      false
    elsif File.exists?(SEMAFOR)
      puts "DeployApp: Another deploy already in progress"
      false
    else
      true
    end
  end

  # The actual deploy
  def deploy
    %x{cd #{DEPLOY_DIR} && git pull > /dev/null && touch tmp/restart.txt}
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
