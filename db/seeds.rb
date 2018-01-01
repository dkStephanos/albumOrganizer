require 'pry'
# Creates artist, user, and association
beatles = Artist.create(name: "The Beatles", bio: "The greatest band of all time.")
user = User.create(email: "koi@me.com", password: "password", password_confirmation: "password")
usr_btls = UserArtist.create(user_id: user.id, artist_id: beatles.id)

# Creates albums for artist
magicalMysteryTour = beatles.albums.create(name: "The Magical Mystery Tour", release_date: 1967)
rubberSoul = beatles.albums.create(name: "Rubber Soul", release_date: 1965)

# Creates songs for albums
magicalMysteryTour.songs.create(name: "Magical Mystery Tour", length: 168)
magicalMysteryTour.songs.create(name: "The Fool on the Hill", length: 180)
magicalMysteryTour.songs.create(name: "Flying", length: 136)
magicalMysteryTour.songs.create(name: "Blue Jay Way", length: 230)
magicalMysteryTour.songs.create(name: "Your Mother Should Know", length: 155)
magicalMysteryTour.songs.create(name: "I Am the Walrus", length: 275, is_favorite: true)
magicalMysteryTour.songs.create(name: "Hello, Goodbye", length: 204)
magicalMysteryTour.songs.create(name: "Strawberry Fields Forever", length: 245, is_favorite: true)
magicalMysteryTour.songs.create(name: "Penny Lane", length: 180)
magicalMysteryTour.songs.create(name: "Baby, You're a Rich Man", length: 187)
magicalMysteryTour.songs.create(name: "All You Need Is Love", length: 237)

rubberSoul.songs.create(name: "Drive My Car", length: 145)
rubberSoul.songs.create(name: "Norwegian Wood (This Bird Has Flown)", length: 121, is_favorite: true)
rubberSoul.songs.create(name: "You Won't See Me", length: 198)
rubberSoul.songs.create(name: "Nowhere Man", length: 160)
rubberSoul.songs.create(name: "Think for Yourself", length: 136)
rubberSoul.songs.create(name: "The Word", length: 161)
rubberSoul.songs.create(name: "Michelle", length: 160, is_favorite: true)
rubberSoul.songs.create(name: "What Goes On", length: 167)
rubberSoul.songs.create(name: "Girl", length: 150)
rubberSoul.songs.create(name: "I'm Looking Through You", length: 143)
rubberSoul.songs.create(name: "In My Life", length: 144)
rubberSoul.songs.create(name: "Wait", length: 132)
rubberSoul.songs.create(name: "If I Needed Someone", length: 140)
rubberSoul.songs.create(name: "Run for Your Life", length: 138)