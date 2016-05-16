# coding: utf-8
lib = File.expand_path('../lib', __FILE__)
$LOAD_PATH.unshift(lib) unless $LOAD_PATH.include?(lib)
require 'sensu/plugins/kue/version'

Gem::Specification.new do |spec|
  spec.name          = "sensu-plugins-kue"
  spec.version       = Sensu::Plugins::Kue::VERSION
  spec.authors       = ["Eugene Kazakov"]
  spec.email         = ["eugene.a.kazakov@gmail.com"]

  spec.summary       = %q{Sensu plugin for monitoring Kue job queue}
  spec.description   = %q{Using Kue collect states of jobs in the queue.}
  spec.homepage      = "https://github.com/xgin/sensu-plugins-kue"
  spec.license       = "MIT"

  spec.files         = Dir.glob("lib/**/*")
  spec.bindir        = "exe"
  spec.executables   = Dir.glob("bin/*").map{ |f| File.basename(f) }
  spec.require_paths = ["lib"]

  spec.add_runtime_dependency "sensu-plugin", "~> 1.2"
  spec.add_runtime_dependency "redis", "~>3.2"

  spec.add_development_dependency "bundler", "~> 1.12"
  spec.add_development_dependency "rake", "~> 10.0"
  spec.add_development_dependency "rspec", "~> 3.4"

end
