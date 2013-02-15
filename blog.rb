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
      posts = Dir.glob("posts/*.md").map do |post|
        post = post[/posts\/(.*?).md$/,1]
        Post.new(post)
      end
      posts.sort_by(&:name).reverse
    end

    def partial(page, options={})
      haml "_#{page}".to_sym, options.merge!(:layout => false)
    end

    def url_base
      "http://#{request.host_with_port}"
    end
  end

  get '/index.php' do
    # lol old php shit
    if params[:n]
      redirect REDIRECTS[params[:n]]
    end
    
    redirect '/'
  end

  get '/' do
    source = latest_posts.first
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

  get '/feed' do
    @posts = latest_posts.first(10)

    content_type 'application/atom+xml'
    builder :feed
  end
end
