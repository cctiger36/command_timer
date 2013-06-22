$:.push File.expand_path("../lib", __FILE__)
require "command_timer/version"

Gem::Specification.new do |gem|
  gem.name          = "command_timer"
  gem.version       = CommandTimer::VERSION
  gem.authors       = ["Weihu Chen"]
  gem.email         = ["cctiger36@gmail.com"]
  gem.summary       = %q{Simple tool to execute commands on schedule}
  gem.description   = %q{Simple tool to execute commands on schedule. Designed for maintain web applications.}
  gem.homepage      = "https://github.com/cctiger36/command_timer"
  gem.license       = "MIT"

  gem.files         = Dir["{bin,lib}/**/*"] + ["MIT-LICENSE", "Rakefile", "README.md"]
  gem.bindir        = 'bin'
  gem.executables   = ['cmdtimer']
  gem.test_files    = gem.files.grep(%r{^(test|spec|features)/})
  gem.require_paths = ["lib"]

  gem.add_development_dependency "rspec"
end
