source 'https://rubygems.org'

gem 'rails', '4.1.15'
gem 'rake', '= 0.9.6'
gem 'rack', '= 1.5.2'

group :development, :test do
  gem 'sqlite3'
  gem 'minitest'
  gem 'thor'
  gem 'faker'
  gem "better_errors"
  gem 'binding_of_caller'
end

# we don't need mysql
#group :production, :mysql do
#  gem 'mysql2', '~> 0.3.20' #version >= 4.0.0 is not compatible with this rails version
#end

group :production, :postgresql do
  gem 'pg'
end

# classic gems
gem 'sass-rails', '~> 4.0.5'
gem 'uglifier', '>= 1.3.0'
gem 'coffee-rails', '~> 4.0.0'
gem 'jquery-rails'
gem 'turbolinks'
gem 'jquery-turbolinks'
gem 'jbuilder', '~> 2.0'
gem 'sdoc', '~> 0.4.0',          group: :doc

# assets pipeline
source 'https://rails-assets.org' do
  gem 'rails-assets-bootstrap-sass-official'
  gem 'rails-assets-font-awesome'
  gem 'rails-assets-leaflet'
  gem 'rails-assets-Leaflet.extra-markers'
  gem 'rails-assets-Leaflet.EasyButton'
end

# project related gems
gem 'dotenv-rails'
gem 'puma'
gem 'slim-rails'
gem 'will_paginate'

gem 'non-stupid-digest-assets'
gem 'quiet_assets'

gem 'rufus-scheduler'
gem 'geocoder'
gem 'gon'

# #devise
# gem 'devise'
# gem 'omniauth'
# gem 'omniauth-google-oauth2'

gem 'yaml_db'
#rake db:data:dump   ->   Dump contents of Rails database to db/data.yml
#rake db:data:load   ->   Load contents of db/data.yml into the database