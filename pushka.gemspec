# coding: utf-8
lib = File.expand_path('../lib', __FILE__)
$LOAD_PATH.unshift(lib) unless $LOAD_PATH.include?(lib)
require 'pushka/version'

Gem::Specification.new do |spec|
  spec.name          = "pushka"
  spec.version       = Pushka::VERSION
  spec.authors       = ["t0pep0"]
  spec.email         = ["t0pep0.gentoo@gmail.com"]
  spec.description   = "Gem for send push notification to Android, iOS and Windows Phone "
  spec.summary       = "Send push notification"
  spec.homepage      = ""
  spec.license       = "MIT"

  spec.files         = `git ls-files`.split($/)
  spec.executables   = spec.files.grep(%r{^bin/}) { |f| File.basename(f) }
  spec.test_files    = spec.files.grep(%r{^(test|spec|features)/})
  spec.require_paths = ["lib"]

  spec.add_development_dependency "bundler", "~> 1.3"
  spec.add_development_dependency "rake"
	spec.add_dependency "grocer" #iOS
	spec.add_dependency "gcm" #Android
	spec.add_dependency "daemons" #For daemon
	#spec.add_dependency "ruby-mpns" #WindrowsPhone
end
