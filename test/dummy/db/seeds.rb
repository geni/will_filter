puts 'Removing old tings...'
Thing.destroy_all

puts 'Adding new things...'
Thing.create!(:name => 'one')
Thing.create!(:name => 'two')
Thing.create!(:name => 'three')
