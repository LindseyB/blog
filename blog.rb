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

    def latest_posts(content = false)
      ret = []
      Dir.glob("posts/*.md") do |post|
        post = post[/posts\/(.*?).md$/,1]
        p = Post.new(post)
        if content 
          ret << {:id => post, :title => p.title, :date => p.formatted_date, :url => "/posts/#{post}", :content => p.content}
        else
          ret << {:id => post, :title => p.title, :date => p.formatted_date, :url => "/posts/#{post}"}
        end
      end
      ret.sort{|x,y| y[:id] <=> x[:id]}
    end

    def partial(page, options={})
      haml "_#{page}".to_sym, options.merge!(:layout => false)
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

  get '/rss.xml' do
    @posts = latest_posts(true)

    builder do |xml|
      xml.instruct! :xml, :version => '1.0'
      xml.rss :version => "2.0" do
        xml.channel do
          xml.title "Lindsey Bieda"
          xml.description "Lindsey Bieda's blog."
          xml.link "http://rarlindseysmash.com"

          @posts.each do |post|
            xml.item do
              xml.title post[:title]
              xml.link "http://rarlindseysmash#{post[:url]}"
              xml.description "<![CDATA[ #{post[:content]} ]]>"
              xml.pubDate Time.parse(post[:date].to_s).rfc822()
              xml.guid "http://rarlindseysmash#{post[:url]}"
            end
          end
        end
      end
    end
  end
end
