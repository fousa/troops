# encoding: utf-8

require 'rubygems'
require 'bundler'
begin
  Bundler.setup(:default, :development)
rescue Bundler::BundlerError => e
  $stderr.puts e.message
  $stderr.puts "Run `bundle install` to install missing gems"
  exit e.status_code
end
require 'rake'

require 'jeweler'
Jeweler::Tasks.new do |gem|
  # gem is a Gem::Specification... see http://docs.rubygems.org/read/chapter/20 for more options
  gem.name = "troop"
  gem.homepage = "http://github.com/fousa/troop"
  gem.license = "MIT"
  gem.summary = %Q{Deploy iOS apps with betabuilder}
  gem.description = %Q{Deploy iOS apps with betabuilder}
  gem.email = "jelle@fousa.be"
  gem.authors = ["Jelle Vandebeeck"]
  gem.executables = ['troop']
  # dependencies defined in Gemfile
  gem.add_runtime_dependency 'betabuilder'
  gem.require_paths = ["lib"]
  gem.files = [
    "lib/troop.rb",
    "lib/troop/configuration.rb",
  ]
  gem.version = "0.1.0"
end
Jeweler::RubygemsDotOrgTasks.new
