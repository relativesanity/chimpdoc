# -*- encoding: utf-8 -*-
$:.push File.expand_path('../lib', __FILE__)
require 'chimpdoc/version'

Gem::Specification.new do |s|
  s.name = 'chimpdoc'
  s.version = Chimpdoc::VERSION
  s.platform = Gem::Platform::RUBY
  s.authors = ['Jonathan Barrett']
  s.email = ['j.e.barrett@gmail.com']
  s.summary = %q{A super-simple publication system}
  s.description = %q{A super-simple publication system built around documents and files}

  s.add_dependency 'dropbox-sdk'
  s.add_development_dependency 'rspec'

  s.files = `git ls-files`.split("\n")
  s.test_files = `git ls-files -- {spec,features}/*`.split("\n")
  s.require_paths = ['lib']
end