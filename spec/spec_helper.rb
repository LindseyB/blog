# spec/spec_helper.rb
require "rack/test"
require "rspec"
require "webmock/rspec"

ENV["RACK_ENV"] = "test"

require File.expand_path "../../blog.rb", __FILE__

module RSpecMixin
  include Rack::Test::Methods
  def app
    Blog
  end
end

RSpec.configure { |c| c.include RSpecMixin }
WebMock.disable_net_connect!(allow_localhost: true)
