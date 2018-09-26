require_relative('models/space_bounties.rb')
require('pry')
Bounties.delete_all()

bounty1 = Bounties.new({
  'name' => 'Zarflop Granular',
  'species' => 'Splarj',
  'bounty' => 70000
})

bounty2 = Bounties.new({
  'name' => 'Beeflord Jamstar',
  'species' => 'Giant Sentient Carrot',
  'bounty' => 120000
})

bounty3 = Bounties.new({
  'name' => 'Percival Schwoop',
  'species' => 'Slartian',
  'bounty' => 1400
})

bounty1.save()
bounty2.save()
bounty3.save()

quitloop = false

until quitloop == true
  p "=================================="
  p "Select an Option"
  p "=================================="
  p "1 - View all Bounties"
  p "2 - Add a Bounty"
  p "3 - Update a Bounty"
  p "4 - Delete a Bounty"
  p "5 - Quit"
  p "=================================="
  p "Make a selection: "
  input = gets.chomp.to_i

  case input
    when 1
      p "=================================="
      p "View All Bounties"
      p "=================================="
      bounty_list = Bounties.all()
      bounty_list.each do |bounty|
        p "Bounty #{bounty.id}: #{bounty.name} (#{bounty.species}) - Ω#{bounty.bounty}"
      end
      if bounty_list.count == 0
        p "No Records"
      end
    when 2
      p "=================================="
      p "Add a Bounty"
      p "=================================="
      p "Name: "
      name = gets.chomp
      p "Species: "
      species = gets.chomp
      p "Bounty Amount: "
      bounty = gets.chomp.to_i

      new_bounty = Bounties.new({
        'name' => name,
        'species' => species,
        'bounty' => bounty
      })
      new_bounty.save()
    when 3
      p "=================================="
      p "Update a Bounty"
      p "=================================="
      # ask for then display entry to be edited
      p "Enter an ID to alter: "
      id = gets.chomp.to_i
      bounty_list = Bounties.view_one(id)

      name = bounty_list[0].name
      species = bounty_list[0].species
      bounty = bounty_list[0].bounty.to_i
      id = bounty_list[0].id.to_i

      p "Bounty #{id}: #{name} (#{species}) - Ω#{bounty}"



      # ask which attribute to change
      p "name - Change Name"
      p "species - Change Species"
      p "bounty - Change Bounty Amount"
      edit_input = gets.chomp
      #update attribute
      case edit_input
        when 'name'
          p "Input Name: "
          name = gets.chomp
        when 'species'
          p "Input Species: "
          species = gets.chomp
        when 'bounty'
          p "Input Bounty: "
          bounty = gets.chomp.to_i
        else
          p "Incorrect Input"
      end
      # binding.pry
      Bounties.update(name,species,bounty,id)
    when 4
      p "=================================="
      p "Delete a Bounty"
      p "=================================="
      p "Type the ID of the Bounty to delete, or 'all' to remove all records."
      delete_input = gets.chomp
      if delete_input == 'all'
        Bounties.delete_all()
      else
        delete_input.to_i
        Bounties.delete(delete_input)
      end
    else
      p "Goodbye"
      quitloop = true

  end
end
