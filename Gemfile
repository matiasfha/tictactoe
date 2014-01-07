source 'https://rubygems.org'

ruby "2.0.0"
gem 'rails', '4.0.0'

# Bundle edge Rails instead:
# gem 'rails', :git => 'git://github.com/rails/rails.git'

gem 'sqlite3', group: :development

group :development, :test do
  gem 'rspec-rails'
  gem 'quiet_assets'
  gem "better_errors", ">= 0.6.0"
end


# Gems used only for assets and not required
# in production environments by default.
group :assets do
  gem 'sass-rails', '~> 4.0.0'
  gem 'coffee-rails', '~> 4.0.0'


  # See https://github.com/sstephenson/execjs#readme for more supported runtimes
  # gem 'therubyracer', :platforms => :ruby

  gem 'uglifier', '>= 1.3.0'
end

gem 'therubyracer', platforms: :ruby
gem 'jquery-rails'
gem 'bootstrap-sass', '~> 3.0.3.0'
gem 'turbolinks'
gem 'unicorn'

group :developent do
   gem 'foreman'
   gem "binding_of_caller"
end

group :production do
    gem 'pg'
    gem 'rails_12factor'
end