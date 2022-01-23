#!/usr/bin/env ruby

require 'bundler/inline'

gemfile do
  source 'https://rubygems.org'
  gem 'paint', '~> 2.2'
end

FACTIONS = {
  Polania: { color: ['B31016', 'FFFFFF'] },
  Saxony:  { color: ['FFE23B', '161616'] },
  Rusviet: { color: ['832B29', 'EF1016'], banned: :Industrial },
  Crimea:  { color: ['3A4810', 'FFC036'], banned: :Patriotic },
  Nordic:  { color: ['3C5CA0', '63C2E9'] },
  Albion:  { color: ['775208', '1C3E19'] },
  Togawa:  { color: ['FFFFFF', '5C1798'] }
}

MATS = {
  Industrial:   { n: '1' },
  Engineering:  { n: '2' },
  Patriotic:    { n: '3' },
  Mechanical:   { n: '4' },
  Agricultural: { n: '5' },
  Militant:     { n: '2A' },
  Innovative:   { n: '3A' }
}

class Scythe
  attr_reader :setups, :faction_queue, :mat_queue
  
  def initialize(players, options={})
    fail "Number of players must be between 1 and 7" if !(1..7).include? players.length
    
    @faction_queue = FACTIONS.keys.shuffle
    @mat_queue = MATS.keys.shuffle
    
    @setups = players.to_h {|player| [player, next_setup]}
  end
  
  def print
    setups.each do |player, setup|
      puts "#{player}: #{faction_s setup[:faction]} / #{mat_s setup[:mat]}"
    end
  end
  
  private
  
  def next_setup
    faction = faction_queue.shift
    # Take the top of mat queue unless it's banned (then take the next one)
    mat = if mat_queue[0] == FACTIONS[faction][:banned]
      mat_queue.slice!(1)
    else
      mat_queue.shift
    end
    {faction: faction, mat: mat}
  end
  
  def faction_s(f)
    Paint[f, :bright, *FACTIONS[f][:color]]
  end
  
  def mat_s(m)
    "#{m} (#{MATS[m][:n]})"
  end
end

s = Scythe.new(ARGV)
s.print
