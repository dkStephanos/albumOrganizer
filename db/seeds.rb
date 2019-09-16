require 'pry'
# Creates artist, user, and association
user = User.create(email: "koi@me.com", password: "password", password_confirmation: "password")
beatles = Artist.create(name: "The Beatles", bio: "The greatest band of all time.", user_id: user.id, :avatar => File.new("#{Rails.root}/app/assets/images/the_beatles.jpg"))

# Creates albums for artist
magicalMysteryTour = beatles.albums.create(name: "The Magical Mystery Tour", release_date: 1967, :album_cover => File.new("#{Rails.root}/app/assets/images/magical_mystery_tour.jpg"))
rubberSoul = beatles.albums.create(name: "Rubber Soul", release_date: 1965, :album_cover => File.new("#{Rails.root}/app/assets/images/rubber_soul.jpg"))

# Creates Genre for songs
rock = Genre.create(name: "Rock N' Roll")

# Creates songs for albums
magicalMysteryTour.songs.create(name: "Magical Mystery Tour", length: 168, genre_id: rock.id)
magicalMysteryTour.songs.create(name: "The Fool on the Hill", length: 180, genre_id: rock.id)
magicalMysteryTour.songs.create(name: "Flying", length: 136, genre_id: rock.id)
magicalMysteryTour.songs.create(name: "Blue Jay Way", length: 230, genre_id: rock.id)
magicalMysteryTour.songs.create(name: "Your Mother Should Know", length: 155, genre_id: rock.id)
magicalMysteryTour.songs.create(name: "I Am the Walrus", length: 275, genre_id: rock.id)
magicalMysteryTour.songs.create(name: "Hello, Goodbye", length: 204, genre_id: rock.id)
strawberry_fields = magicalMysteryTour.songs.create(name: "Strawberry Fields Forever", length: 245, genre_id: rock.id)
magicalMysteryTour.songs.create(name: "Penny Lane", length: 180, genre_id: rock.id)
magicalMysteryTour.songs.create(name: "Baby, You're a Rich Man", length: 187, genre_id: rock.id)
magicalMysteryTour.songs.create(name: "All You Need Is Love", length: 237, genre_id: rock.id)

rubberSoul.songs.create(name: "Drive My Car", length: 145, genre_id: rock.id)
rubberSoul.songs.create(name: "Norwegian Wood (This Bird Has Flown)", length: 121, genre_id: rock.id)
rubberSoul.songs.create(name: "You Won't See Me", length: 198, genre_id: rock.id)
rubberSoul.songs.create(name: "Nowhere Man", length: 160, genre_id: rock.id)
rubberSoul.songs.create(name: "Think for Yourself", length: 136, genre_id: rock.id)
rubberSoul.songs.create(name: "The Word", length: 161, genre_id: rock.id)
michelle = rubberSoul.songs.create(name: "Michelle", length: 160, genre_id: rock.id)
rubberSoul.songs.create(name: "What Goes On", length: 167, genre_id: rock.id)
rubberSoul.songs.create(name: "Girl", length: 150, genre_id: rock.id)
rubberSoul.songs.create(name: "I'm Looking Through You", length: 143, genre_id: rock.id)
rubberSoul.songs.create(name: "In My Life", length: 144, genre_id: rock.id)
rubberSoul.songs.create(name: "Wait", length: 132, genre_id: rock.id)
rubberSoul.songs.create(name: "If I Needed Someone", length: 140, genre_id: rock.id)
rubberSoul.songs.create(name: "Run for Your Life", length: 138, genre_id: rock.id)

# Adds songs to favorites
UserFavoriteSong.create(user_id: user.id, song_id: strawberry_fields.id)
UserFavoriteSong.create(user_id: user.id, song_id: michelle.id)