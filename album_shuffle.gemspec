# coding: utf-8
lib = File.expand_path('../lib', __FILE__)
$LOAD_PATH.unshift(lib) unless $LOAD_PATH.include?(lib)
require 'album_shuffle/version'

Gem::Specification.new do |spec|
  spec.name          = "album_shuffle"
  spec.version       = AlbumShuffle::VERSION
  spec.authors       = ["Dan Schuman"]
  spec.email         = ["danschuman@gmail.com"]
  spec.summary       = %q{Command line tool to list random music directories}
  spec.description   = %q{Outputs a list of shuffled music directories. Assumes your music is already organized in a directory-per-album structure.}
  spec.homepage      = ""
  spec.license       = "MIT"

  spec.files         = `git ls-files`.split($/)
  spec.executables   = spec.files.grep(%r{^bin/}) { |f| File.basename(f) }
  spec.test_files    = spec.files.grep(%r{^(test|spec|features)/})
  spec.require_paths = ["lib"]

  spec.add_development_dependency "bundler", "~> 1.3"
  spec.add_development_dependency "rake"
  spec.add_development_dependency "rspec"

  spec.add_runtime_dependency "thor"
end
