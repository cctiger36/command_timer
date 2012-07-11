# -*- encoding: utf-8 -*-
require File.expand_path('../lib/command_timer/version', __FILE__)

Gem::Specification.new do |gem|
  gem.authors       = ["cctiger36"]
  gem.email         = ["cctiger36@gmail.com"]
  gem.description   = %q{Simple tool to execute commands on schedule}
  gem.summary       = %q{Execute commands on schedule}
  gem.homepage      = "https://github.com/cctiger36/command_timer"

  gem.files         = `git ls-files`.split($\)
  gem.executables   = gem.files.grep(%r{^bin/}).map{ |f| File.basename(f) }
  gem.test_files    = gem.files.grep(%r{^(test|spec|features)/})
  gem.name          = "command_timer"
  gem.require_paths = ["lib"]
  gem.version       = CommandTimer::VERSION
end
