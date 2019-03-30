ENV['BUNDLE_GEMFILE'] ||= File.expand_path('../Gemfile', __dir__)

require 'bundler/setup' # Set up gems listed in the Gemfile.
#Causing an error atm, will resolve later
#require 'bootsnap/setup' # Speed up boot time by caching expensive operations.
