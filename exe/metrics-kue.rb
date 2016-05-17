#! /usr/bin/env ruby

require "sensu-plugin/metric/cli"
require "socket"
require "redis"

class KueMetrics < Sensu::Plugin::Metric::CLI::Graphite
  option :scheme,
         long: "--scheme SCHEME",
         description: "Metric naming scheme, text to prepend to $queue_type",
         default: "#{Socket.gethostname}.kue"

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
    ['complete', 'failed', 'inactive', 'active', 'delayed'].each do |type|
      output "#{config[:scheme]}.#{type}", redis.zcard("#{config[:prefix]}:jobs:#{type}")
    end
    ok
  end

end
