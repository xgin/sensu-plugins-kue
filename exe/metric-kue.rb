#! /usr/bin/env ruby

require "sensu-plugin/metric/cli"
require "redis"

class KueMetric < Sensu::Plugin::Metric::CLI::JSON

  option :prefix,
         short: "-q PREFIX",
         long: "--prefix PREFIX",
         description: "Kue prefix",
         default: "q"

  option :host,
         short: "-h HOST",
         long: "--host HOST",
         description: "Redis Server Hostname"

  option :port,
         short: "-p PORT",
         long: "--port PORT",
         description: "Redis Server Port"

  option :password,
         short: "-a PASSWORD",
         long: "--password PASSWORD",
         description: "Redis Password"

  option :db,
         short: "-n DB",
         long: "--db DB",
         description: "Redis Database Number"

  def run
    redis = Redis.new(config)
    types = ['complete', 'failed', 'inactive', 'active', 'delayed']
    ok types.map{ |type| [type, redis.zcard("#{config[:prefix]}:jobs:#{type}")] }.to_h
  end

end
