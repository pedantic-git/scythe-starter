FACTIONS = {
  Polania: { color: ['B31016', 'FFFFFF'] },
  Saxony:  { color: ['FFE23B', '161616'] },
  Rusviet: { color: ['832B29', 'EF1016'], banned: :Industrial },
  Crimea:  { color: ['3A4810', 'FFC036'], banned: :Patriotic },
  Nordic:  { color: ['3C5CA0', '63C2E9'] },
  Albion:  { color: ['775208', '1C3E19'], ifa: true },
  Togawa:  { color: ['FFFFFF', '5C1798'], ifa: true }
}

MATS = {
  Industrial:   { n: '1' },
  Engineering:  { n: '2' },
  Patriotic:    { n: '3' },
  Mechanical:   { n: '4' },
  Agricultural: { n: '5' },
  Militant:     { n: '2A', ifa: true },
  Innovative:   { n: '3A', ifa: true }
}

S_BONUSES = [
  'Tunnels adjacent', 'Lakes adjacent', 'Encounters adjacent',
  'On tunnels', 'In a row', 'On farms or tundras'
]

class Scythe
  attr_reader :players, :setups, :faction_queue, :mat_queue, :s_bonus, :ifa
  
  def initialize(players, ifa: false)
    fail "Number of players must be between 1 and 7" if !(1..7).include? players.length
    @players = players
    @ifa = ifa
    
    shuffle
    generate_setups
  end
  
  private
  
  def shuffle
    @faction_queue = valid_factions.shuffle
    @mat_queue = valid_mats.shuffle
    @s_bonus = S_BONUSES.sample
  end
  
  def generate_setups
    @setups = players.to_h {|player| [player, next_setup]}
  end
  
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
  
  def valid_factions
    if ifa
      FACTIONS.keys
    else
      FACTIONS.keys.reject {|f| FACTIONS[f][:ifa]}
    end
  end
  
  def valid_mats
    if ifa
      MATS.keys
    else
      MATS.keys.reject {|m| MATS[m][:ifa]}
    end
  end
  
  def player_length
    setups.keys.map(&:length).max
  end
end
