puts 'destroying everything...'

User.destroy_all
Garden.destroy_all

puts 'everything destroyed!'

user1 = User.new(
    email: 'david@ducobu.com',
    password:'12345678'
  )
user1.save!

userlmbd = User.new(
    email: 'lambda@ducobu.com',
    password:'12345678'
  )
userlmbd.save!

garden_names = [
  'French garden',
  'My Cute Balcony',
  'English garden',
  'Flowered patio',
  'Garden in Japan',
  'Walk among flowers'
]

garden_names.each do |garden_name|
  puts "creating #{garden_name}..."
  garden_request = RestClient.get('https://source.unsplash.com/1200x700/?garden')
  garden = Garden.new(
      name: garden_name,
      banner_url: garden_request.request.url,
      user: user1
    )
  garden.save!
  3.times do
    plant_request = RestClient.get('https://source.unsplash.com/400x300/?flower')
    plant = Plant.new(
      name: Faker::FunnyName.name,
      image_url: plant_request.request.url
    )
    plant.garden = garden
    plant.save!
    sleep(2)
  end
  puts "#{garden_name} created!"
end
