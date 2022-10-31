source "https://rubygems.org"

ruby "2.7.2"

gem "sinatra"
gem "sinatra-subdomain"
gem "sinatra-contrib", require: "sinatra/content_for"
gem "titleize"
gem "rake"
gem "haml", "~> 6.0.8"
gem "httparty"
gem "redcarpet"
gem "builder"
gem "pry"
gem "sanitize"
gem "rack-ssl"
gem "dotenv"
gem "puma"
gem "standard", group: [:development, :test]
gem "nokogiri", ">= 1.11.0.rc4"

if RUBY_PLATFORM.match?(/win32/)
  gem "eventmachine", "~> 1.0.0.beta.4.1"
end

group :test do
  gem "rack-test"
  gem "rspec"
  gem "webmock"
end
