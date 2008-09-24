#!/usr/bin/env rackup

require 'deploy_app'

use Rack::CommonLogger
use Rack::Lint
run DeployApp.new
