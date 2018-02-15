lib = File.expand_path('../lib', __FILE__)
$LOAD_PATH.unshift(lib) unless $LOAD_PATH.include?(lib)
require 'gmc/version'

Gem::Specification.new do |spec|
  spec.name          = 'gmc'
  spec.version       = Gmc::VERSION
  spec.authors       = ['HealtheIntent Infrastructure Dark Knight']
  spec.email         = ['DL_Dark_Knight@cerner.com']
  spec.summary       = %q{A CLI to generate healtheintent mesos config files using config defined in gmc.yml}
  spec.description   = %q{To CLI to generate mesos config files for you, your gmc.yml should have following minimum configurations.}
  spec.files         = `git ls-files -z`.split("\x0").reject do |f|
    f.match(%r{^(test|spec|features)/})
  end
  spec.bindir        = 'bin'
  spec.executables  << 'gmc'
  spec.require_paths = ['lib']

  spec.add_runtime_dependency 'activesupport', '~> 5.1'
end
