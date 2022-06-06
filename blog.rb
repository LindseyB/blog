require "bundler"
Bundler.require

require "date"
require_relative "post"
require_relative "redirects"
require_relative "projects"

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
      posts = Dir.glob("posts/*.md").map { |post|
        post = post[/posts\/(.*?).md$/, 1]
        Post.new(post)
      }
      posts.reject! { |post| post.date > Date.today }
      posts.sort_by(&:date).reverse
    end

    def partial(page, options = {})
      haml "_#{page}".to_sym, options.merge!(layout: false)
    end

    def url_base
      "#{request.secure? ? "https" : "http"}://#{request.host_with_port}"
    end

    def get_projects
      projects = PROJECTS

      # Get projects from itch and then make an array
      api_key = ENV.fetch("ITCH_API_KEY", "")
      games = HTTParty.get("https://itch.io/api/1/#{api_key}/my-games")

      games["games"].each do |game|
        unless projects.any? { |h| h[:name] == game["title"] }
          projects << {name: game["title"], link: game["url"], image: game["cover_url"]}
        end
      end

      @projects = projects.shuffle
    end
  end

  before do
    cache_control :public, :must_revalidate, max_age: 60
  end

  get "/index.php" do
    # lol old php shit
    if params[:n]
      redirect REDIRECTS[params[:n]]
    end

    redirect "/projects"
  end

  get "/" do
    redirect "/projects"
  end

  get "/posts/:id" do
    source = Post.new(params[:id])
    if source.title.nil?
      halt 404
    else
      @content = source.content
      @title = source.title
      @date = source.date
      @formatted_date = source.formatted_date
      @blurb = source.blurb(200)
      @image = source.image

      haml :post
    end
  end

  get "/archive" do
    @title = "Blog Archive"

    @posts = latest_posts

    haml :archive
  end

  get "/projects" do
    @title = "Projects"

    @projects = get_projects

    haml :projects
  end

  get "/about" do
    @title = "About"

    haml :about
  end

  get "/links" do
    @title = "Links"

    haml :links
  end

  get "/rss.xml" do
    @posts = latest_posts.first(10)

    content_type "application/atom+xml"
    builder :feed
  end

  not_found { haml :"404" }
end
