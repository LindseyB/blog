require 'bundler'
Bundler.require

require_relative 'post'

class Blog < Sinatra::Base
  helpers do
  end

  get '/' do
    haml :index
  end

  get '/posts/:id' do
    source = Post.new(params[:id])
    @content = source.content
    @title = source.title

    haml :post
  end
end
