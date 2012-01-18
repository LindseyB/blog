require 'bundler'
Bundler.require

require_relative 'post'

class Blog < Sinatra::Base
  TITLE = "Wilkie Writes a Thing"
  GITHUB_USERNAME = "wilkie"
  TWITTER_USERNAME = "DaveWilkinsonII"
  RSTATUS_USERNAME = "DaveWilkinsonII"

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
    @author = source.author

    haml :post
  end
end
