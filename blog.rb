require 'bundler'
Bundler.require

require 'date'
require_relative 'post'
require_relative 'redirects'

Dotenv.load

class Blog < Sinatra::Base
  TITLE = "Lindsey Bieda"
  helpers Sinatra::ContentFor

  helpers do
    def title
      return TITLE if @title.nil?
      "#{TITLE} &raquo; #{@title}"
    end

    def description
      return title if @blurb.nil?
      @blurb
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
      "#{request.secure? ? "https" : "http"}://#{request.host_with_port}"
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
      @blurb = source.blurb(200)
      @image = source.image

      haml :post
    else
      halt 404
    end
  end

  get '/archive' do
    @title = "Blog Archive"

    @posts = latest_posts

    haml :archive
  end

  get '/projects' do
    @title = "Projects"
    # Get projects from itch and then make an array
    @projects = [
      {name: "Star Wars Gifs", link: "https://rarlindseysmash.com/posts/stupid-programmer-tricks-and-star-wars-gifs", image: "https://i.imgur.com/8PJevlr.gif"},
      {name: "XOmBot", link: "https://github.com/LindseyB/XOmBot", image: "https://rarlindseysmash.com/images/projects/xombot.png"},
      {name: "Pride, Prejudice, Dungeons, and Dragons", link: "https://github.com/LindseyB/pride-prejudice-dungeons-dragons", image: "https://pbs.twimg.com/media/CUzh7m9XAAAPjwH.png"},
      {name: "Green Jellybean Love Stars", link: "https://www.youtube.com/watch?v=fEEAONl4qos", image: "https://i.imgur.com/aoYrnMu.png"},
      {name: "Iron Trotter", link: "https://github.com/LindseyB/IronTrotter", image: "https://i.imgur.com/CiGUh56.png"},
      {name: "Ascii Ascii Revolution", link: "https://github.com/LindseyB/AsciiAsciiRevolution", image: "https://imgur.com/8KY9fln.png"},
      {name: "LED Hula Hoops", link: "https://rarlindseysmash.com/posts/diy-led-hula-hoop", image: "https://i.imgur.com/26yZsc8.gif"},
      {name: "Accelerometer Galaxy Scarf", link: "https://github.com/LindseyB/galaxy-scarf", image: "https://i.giphy.com/l2Sq2kyWwZj37locg.gif"}
    ]

    games = HTTParty.get("https://itch.io/api/1/#{ENV.fetch('ITCH_API_KEY')}/my-games")

    games["games"].each do |game|
      @projects << {name: game["title"], link: game["url"], image: game["cover_url"]}
    end

    @projects.shuffle

    haml :projects
  end

  get '/about' do
    @title = "About"
    haml :about
  end

  get '/rss.xml' do
    @posts = latest_posts.first(10)

    content_type 'application/atom+xml'
    builder :feed
  end

  not_found { haml :'404' }
end
