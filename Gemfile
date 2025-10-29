source "https://rubygems.org"
ruby "3.2.3"

gem "rails", "~> 7.1.5"
gem "pg", "~> 1.5"
gem "puma", "~> 7.1.0"
gem "bootsnap", require: false
gem "faraday", "~> 2.8"
gem "geocoder", "~> 1.8"
gem "dotenv-rails", groups: [:development, :test]
gem "tzinfo-data", platforms: [:mingw, :mswin, :x64_mingw, :jruby]
gem "sprockets-rails"

# For caching in production you can switch to redis (not included here)
# gem 'redis', '~> 5.0'

group :development, :test do
  gem "byebug"
  gem "rspec-rails", "~> 6.0"
  gem "webmock"
  gem "vcr"
end

group :test do
  gem "capybara"
end
