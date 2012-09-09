User.delete_all
Request.delete_all

Request.create!(request_type: 'music', artist: 'Squirrel Nut Zippers',
  album: 'Hot')
Request.create!(request_type: 'music', artist: 'Big Giant Circles',
  album: 'Imposter Nostalgia')
Request.create!(request_type: 'music', artist: 'American Idiot',
  album: 'Green Day')

Request.create!(request_type: 'movies',
  title: 'Pirates of the Caribbean: The Curse of the Black Pearl')
Request.create!(request_type: 'movies',
  title: 'Ocean\'s Eleven')
Request.create!(request_type: 'movies',
  title: 'Casablanca')

Request.create!(request_type: 'tv-shows',
  title: 'How I Met Your Mother')
Request.create!(request_type: 'tv-shows',
  title: 'Doctor Who')
Request.create!(request_type: 'tv-shows',
  title: 'Firefly')

Request.create!(request_type: 'software',
  title: 'Adobe Photoshop CS5')

Request.create!(request_type: 'games',
  title: 'Team Fortress 2')

Request.create!(request_type: 'other',
  title: 'That one thing.')
