require_relative('models/space_bounties.rb')
require('pry')
Bounties.delete_all()

bounty1 = Bounty.new({
  'name' => 'Zarflop Granular',
  'species' => 'Splarj',
  'bounty' => 70000
})

bounty2 = Bounty.new({
  'name' => 'Beeflord Jamstar',
  'species' => 'Giant Sentient Carrot',
  'bounty' => 120000
})

bounty3 = Bounty.new({
  'name' => 'Percival Schwoop',
  'species' => 'Slartian',
  'bounty' => 1400
})

bounty1.add_bounty()
