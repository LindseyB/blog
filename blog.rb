require 'bundler'
Bundler.require

require_relative 'post'

class Blog < Sinatra::Base
  TITLE = "wilkie writes a thing"
  GITHUB_USERNAME = "wilkie"
  TWITTER_USERNAME = "DaveWilkinsonII"
  RSTATUS_USERNAME = "DaveWilkinsonII"

  helpers Sinatra::ContentFor

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
    haml :index
  end

  get '/posts/:id' do
    source = Post.new(params[:id])
    @content = source.content
    @title = source.title
    @author = source.author
    @date = source.date
    @outline = source.outline

    haml :post
  end
end
