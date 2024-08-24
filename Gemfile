source "https://rubygems.org"
git_source(:github) { |repo| "https://github.com/#{repo}.git" }

ruby file: ".ruby-version"

gem "barby"
gem "bootsnap", require: false
gem "cancancan"
gem "devise"
gem "enumerize"
gem "haml"
gem "haml-rails"
gem "has_scope"
gem "heroicon"
gem "importmap-rails"
gem "jbuilder"
gem "kaminari"
gem "liquid"
gem "pg", "~> 1.5"
gem "propshaft"
gem "puma", "~> 6.4"
gem "rails", "~> 7.1.3"
gem "rqrcode"
gem "simple_form"
gem "solid_queue", "~> 0.6.0"
gem "sqlite3", "~> 1.4"
gem "stimulus-rails"
gem "tailwindcss-rails"
gem "turbo-rails"
gem "tzinfo-data", platforms: %i[mingw mswin x64_mingw jruby]

group :development do
  gem "web-console"
end

group :test do
  gem "capybara"
  gem "capybara-screenshot"
  gem "selenium-webdriver"
  gem "webdrivers"
end

group :development, :test do
  gem "debug", platforms: %i[mri mingw x64_mingw]
  gem "factory_bot"
  gem "factory_bot_rails"
  gem "faker"
  gem "rspec-rails"
  gem "standard"
end
