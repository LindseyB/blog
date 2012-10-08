require 'bundler'
Bundler.require

require 'date'
require_relative 'post'

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
      ret
    end

    def partial(page, options={})
      haml "_#{page}".to_sym, options.merge!(:layout => false)
    end

    def format_outline(outline)
      return "" if outline.nil?
      if outline.text == "References"
        "</ul><li><a href='##{outline.slug}'>#{outline.text}</a></li>#{format_outline(outline.sibling)}<ul>"
      else
        "<li><a href='##{outline.slug}'>#{outline.text}</a><ul>#{format_outline(outline.child)}</ul></li>#{format_outline(outline.sibling)}"
      end
    end
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
