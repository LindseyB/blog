require 'bundler'
Bundler.require

require_relative 'post'

class Blog < Sinatra::Base
  TITLE = "wilkie writes a thing"
  GITHUB_USERNAME = "wilkie"
  TWITTER_USERNAME = "DaveWilkinsonII"
  RSTATUS_USERNAME = "DaveWilkinsonII"

  helpers do
    def title
      return TITLE if @title.nil?
      "#{@title} - #{TITLE}"
    end

    def latest_posts
      ret = []
      Dir.glob("posts/*.md") do |post|
        post = post[/posts\/(.*?).md$/,1]
        p = Post.new(post)
        ret << {:title => p.title, :url => "/posts/#{post}"}
      end
      ret
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
    @date = source.date

    haml :post
  end
end
