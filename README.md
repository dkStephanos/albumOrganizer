# albumOrganizer
A Ruby on Rails application that allows users to create accounts from which they can create their own Artists/Albums/Songs/Genres. Users may also view all created data from other users, change or delete their own, or even mark songs they have contributed to their own favorite list.


## Installation

To use this app, just clone, run 'bundle install' and then run 'rake db:migrate' and 'rake db:seed.' You can start the servers using 'rails s.' To enable Facebook login, you will have to add your own '.env' file with the appropriate key and secretvalue from Facebook's developer site.

This app also uses paperclip which relies on ImageMagik.

On OS X, the preferred way to install ImageMagick is with Homebrew:

brew install imagemagick

On Linux, use apt-get:

sudo apt-get install imagemagick -y

If you are using another system, you can get download and install instructions from the ImageMagick website.

## Usage

Create an account on the home page or login with Facebook. Once logged in, user may view all other Artsits/Albums/Songs that have been created by other users, and may create, update or destroy data they themselves created. Users may also add Songs they have added to their favorites by selecting isFavorite on the Song creation or edit page. Favorited songs and created artists are both listed on the User's show page.

## Contributing

Bug reports and pull requests are welcome on GitHub at https://github.com/'dkStephanos'/albumOrganizer. This project is intended to be a safe, welcoming space for collaboration, and contributors are expected to adhere to the [Contributor Covenant](http://contributor-covenant.org) code of conduct.

## License

This project is available as open source under the terms of the [MIT License](http://opensource.org/licenses/MIT).
