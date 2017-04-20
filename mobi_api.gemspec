# coding: utf-8
lib = File.expand_path('../lib', __FILE__)
$LOAD_PATH.unshift(lib) unless $LOAD_PATH.include?(lib)
require 'mobi_api/version'

Gem::Specification.new do |spec|
  spec.name          = "mobi_api"
  spec.version       = MobiApi::VERSION
  spec.authors       = ["David McVicar"]
  spec.email         = ["machvee@gmail.com"]

  spec.summary       = %q{Ruby API for Mobikaze Merchant Checkin and Game Apps}
  spec.homepage      = "http://www.mbkze.com"
  spec.license       = "MIT"

  spec.files         = `git ls-files -z`.split("\x0").reject do |f|
    f.match(%r{^(test|spec|features)/})
  end
  spec.bindir        = "exe"
  spec.executables   = spec.files.grep(%r{^exe/}) { |f| File.basename(f) }
  spec.require_paths = ["lib"]

  spec.add_development_dependency "bundler", "~> 1.13"
  spec.add_development_dependency "rake", "~> 10.0"
  spec.add_development_dependency "minitest", "~> 5.0"
  spec.add_dependency "json_api_client", "~> 1.0"
end
