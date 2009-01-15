require 'rubygems'
require 'rack'
require 'json'
 
class DeployApp
  DEPLOY_DIR = File.expand_path(File.dirname(__FILE__))
  SEMAFOR = File.join(DEPLOY_DIR, ".deploying")

  DEBUG = true

  # Does what it says on the tin. By default, not much, it just prints the
  # received payload.
  def handle_request
    return not_found unless request_is_ok?

    payload = JSON.parse(@req.POST["payload"])

    if do_deploy?(payload)
      debug "decided to deploy"
      FileUtils.touch(SEMAFOR)
      deploy
      FileUtils.rm(SEMAFOR)
      @res.write "Deployment in progress, check back later"
    else
      debug "decided not to deploy"
      @res.write "Not deploying"
    end
  end

  # Checks commit messages to determine if we are to deploy
  def do_deploy?(payload)
    unless payload['commits'] and not (commits = Array(payload['commits'])).empty?
      debug "not a GitHub payload"
      return false
    end
    commits.inject(false) do |choice, commit|
      case commit['message']
      when /:don'?t[ _-]deploy:/i
        false
      when /:deploy:/i
        true
      else
        choice
      end
    end
  end

  # Is it a correct request and aren't we deploying already
  def request_is_ok?
    if @req.POST["payload"].nil?
      debug "no payload"
      false
    elsif @req.path_info != '/deploy'
      debug "POST with payload but not to '/deploy'"
      false
    elsif File.exists?(SEMAFOR)
      debug "another deploy already in progress"
      false
    else
      true
    end
  end

  # The actual deploy
  def deploy
    cmd = %{cd #{DEPLOY_DIR} && git pull > /dev/null && webby && touch tmp/restart.txt}
    debug "running: #{cmd}"
    system(cmd)
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

  # Output debug infos
  def debug(msg)
    puts "DeployApp: #{msg}" if DEBUG
  end
end
