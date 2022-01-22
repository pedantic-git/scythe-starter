#!/usr/bin/env ruby

FACTIONS = %w[Polania Saxony Rusviet Crimea Nordic Albion Togawa]
MATS = %w[Agricultural Engineering Industrial Mechanical Patriotic Innovative Militant]

FACTIONS.shuffle!
MATS.shuffle!

puts "Emily: #{FACTIONS[0]} / #{MATS[0]}"
puts "Quinn: #{FACTIONS[1]} / #{MATS[1]}"

