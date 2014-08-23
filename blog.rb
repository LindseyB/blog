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
      posts.reject! {|post| post.date > Date.today }
      posts.sort_by(&:date).reverse
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
    redirect '/posts/' + latest_posts.first.name
  end

  get '/posts/:id' do
    source = Post.new(params[:id])
    unless source.title.nil?
      @content = source.content
      @title = source.title
      @date = source.date
      @formatted_date = source.formatted_date

      haml :post
    else
      halt 404
    end
  end

  get '/archive' do
    count = 10
    @page = params[:page].to_i || 0
    @max_page = latest_posts.count/count

    @posts = latest_posts[(@page * count)..((@page * count) + count)]

    haml :archive
  end

  get '/rss.xml' do
    @posts = latest_posts.first(10)

    content_type 'application/atom+xml'
    builder :feed
  end

  not_found { haml :'404' }
end
