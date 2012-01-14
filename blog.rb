require 'bundler'
Bundler.require

require_relative 'post'

class Blog < Sinatra::Base
  TITLE = "Wilkie"

  helpers do
    def title
      return TITLE if @title.nil?
      "#{@title} - #{TITLE}"
    end
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
