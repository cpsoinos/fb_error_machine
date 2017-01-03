# coding: utf-8
lib = File.expand_path('../lib', __FILE__)
$LOAD_PATH.unshift(lib) unless $LOAD_PATH.include?(lib)
require 'fb_error_machine/version'

Gem::Specification.new do |spec|
  spec.name          = "fb_error_machine"
  spec.version       = FbErrorMachine::VERSION
  spec.authors       = ["Corey Psoinos"]
  spec.email         = ["coreypsoinos@gmail.com"]

  spec.summary       = %q{A glossary for Facebook error codes.}
  spec.description   = %q{A simple scraper to pull Facebook's list of error codes and descriptions from the documentation.}
  spec.homepage      = "TODO: Put your gem's website or public repo URL here."
  spec.license       = "MIT"

  spec.files         = `git ls-files -z`.split("\x0").reject do |f|
    f.match(%r{^(test|spec|features)/})
  end
  spec.bindir        = "bin"
  spec.executables   = spec.files.grep(%r{^bin/}) { |f| File.basename(f) }
  spec.require_paths = ["lib"]

  spec.add_development_dependency "bundler", "~> 1.13"
  spec.add_development_dependency "rake", "~> 10.0"
  spec.add_development_dependency "rspec", "~> 3.2"

  # ["scrape_fb_errors", "scrape_fb_graph_api_errors", "scrape_fb_marketing_api_errors"].each do |executable|
  #   spec.executables << executable
  # end
end
