#!/usr/bin/env ruby

# start.rb Alice Bob Charlie Dave Erin
# start.rb --help

require 'bundler/inline'
require_relative 'scythe'

gemfile do
  source 'https://rubygems.org'
  gem 'clamp', '~> 1.3'
  gem 'paint', '~> 2.2'
end

Clamp.allow_options_after_parameters = true
Clamp do
  parameter "PLAYERS ...", "a list of players", attribute_name: :players
  option "--[no-]ifa", :flag, "Invaders From Afar expansion?", default: true
  option "--[no-]twg", :flag, "The Wind Gambit expansion? (Airships + Resolutions)", default: false
  option "--[no-]airships", :flag, "Airships module?", default: false
  option "--[no-]resolutions", :flag, "Resolutions module?", default: false
  
  def execute
    Scythe.new(players, ifa: ifa?, airships: (twg? || airships?), resolutions: (twg? || resolutions?)).print
  end
end
