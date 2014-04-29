source 'https://rubygems.org'

gem 'rails', '3.2.16'

gem 'sqlite3'
gem 'haml'
gem 'haml-rails'
#gem 'haml-contrib'
#gem 'RedCloth'
gem 'bootstrap-sass', '2.3.2.0'
#gem 'sprockets', '2.11.0'

# Gems used only for assets and not required
# in production environments by default.
group :assets do
  gem 'sass-rails',   '~> 3.2.3'
  gem 'coffee-rails', '~> 3.2.1'
  gem 'uglifier', '>= 1.0.3'
end

gem 'jquery-rails'

group :devolopment, :test do
  gem 'rspec-rails', '2.13.1'
end

group :test, :devolopment do
	gem 'cucumber-rails', :require => false
	gem 'cucumber-rails-training-wheels'
	gem 'database_cleaner'
	gem 'capybara'
	gem 'launchy'
end
