#!/usr/bin/env ruby

require 'paint'

FACTIONS = {
  Polania: {
    color: 'fff',
  },
  Saxony: {
    color: :inverse,
  },
  Rusviet: {
    color: 'f00',
    banned: :Industrial,
  },
  Crimea: {
    color: 'ff0',
    banned: :Patriotic
  },
  Nordic: {
    color: '00f',
  },
  Albion: {
    color: '0f0',
  },
  Togawa: {
    color: 'f0f',
  }
}

MATS = {
  Agricultural: {
    n: '5'
  },
  Engineering: {
    n: '2'
  },
  Industrial: {
    n: '1'
  },
  Mechanical: {
    n: '4'
  },
  Patriotic: {
    n: '3'
  },
  Innovative: {
    n: '3A'
  },
  Militant: {
    n: '2A'
  }
}

players = ARGV
fail "Please specify player names on the command line" if players.empty?

faction_order = FACTIONS.keys.shuffle
mat_order = MATS.keys.shuffle

players.each do |player|
  faction = faction_order.shift
  mat = if mat_order[0] == FACTIONS[faction][:banned]
    mat_order.splice(1)
  else
    mat_order.shift
  end
  
  puts "#{player}: #{Paint[faction, :bright, FACTIONS[faction][:color]]} / #{mat} (#{MATS[mat][:n]})"
end
