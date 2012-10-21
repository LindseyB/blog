require 'bundler'
Bundler.require

require 'date'
require_relative 'post'
require_relative 'redirects'

class Blog < Sinatra::Base
  TITLE = "Lindsey Bieda"

  helpers Sinatra::ContentFor

  helpers do
    def title
      return TITLE if @title.nil?
      "#{TITLE} &raquo; #{@title}"
    end

    def latest_posts
      ret = []
      Dir.glob("posts/*.md") do |post|
        post = post[/posts\/(.*?).md$/,1]
        p = Post.new(post)
        ret << {:id => post, :title => p.title, :url => "/posts/#{post}"}
      end
      ret.sort{|x,y| y[:id] <=> x[:id]}
    end

    def partial(page, options={})
      haml "_#{page}".to_sym, options.merge!(:layout => false)
    end
  end

  get '/index.php' do
    # lol old php shit
    REDIRECTS.each do |hsh|
      if hsh[:n].eql? params[:n]
        redirect hsh[:to], 301
      end
    end
    
    redirect '/'
  end

  get '/' do
    source = Post.new(latest_posts[0][:id])
    @content = source.content
    @title = source.title
    @date = source.date
    @formatted_date = source.formatted_date

    haml :post
  end

  get '/posts/:id' do
    source = Post.new(params[:id])
    @content = source.content
    @title = source.title
    @date = source.date
    @formatted_date = source.formatted_date

    haml :post
  end

  get '/archive' do
    @posts = latest_posts

    haml :archive
  end
end
