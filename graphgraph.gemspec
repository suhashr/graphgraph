# coding: utf-8
lib = File.expand_path('../lib', __FILE__)
$LOAD_PATH.unshift(lib) unless $LOAD_PATH.include?(lib)
require 'graphgraph/version'

Gem::Specification.new do |spec|
  spec.name          = "graphgraph"
  spec.version       = Graphgraph::VERSION
  spec.authors       = ["Suhas Shrestha"]
  spec.email         = ["suhas.shrestha1@gmail.com"]

  spec.summary       = %q{This gem will generate graphs based on models it is wrapped around.}
  spec.description   = %q{View for each model is generated and selection of multiple graphing options is provided.}
  spec.homepage      = ""
  spec.license       = "MIT"

  # Prevent pushing this gem to RubyGems.org by setting 'allowed_push_host', or
  # delete this section to allow pushing this gem to any host.


  spec.files         = `git ls-files -z`.split("\x0").reject { |f| f.match(%r{^(test|spec|features)/}) }
  spec.bindir        = "exe"
  spec.executables   = spec.files.grep(%r{^exe/}) { |f| File.basename(f) }
  spec.require_paths = ["lib"]

  spec.add_development_dependency "bundler", "~> 1.11"
  spec.add_development_dependency "rake", "~> 10.0"
  spec.add_development_dependency "bootstrap-sass", "~> 3.3.6"
  spec.add_development_dependency "lazy_high_charts", ">=1.0.0"
  spec.add_development_dependency 'momentjs-rails', '>= 2.9.0'
  spec.add_development_dependency 'bootstrap3-datetimepicker-rails', '~> 4.17.42'
  spec.add_runtime_dependency "bootstrap-sass", "~> 3.3.6"
  spec.add_runtime_dependency "lazy_high_charts", ">=1.0.0"
  spec.add_runtime_dependency 'momentjs-rails', ">= 2.9.0"
  spec.add_runtime_dependency 'bootstrap3-datetimepicker-rails', "~> 4.17.42"
end
