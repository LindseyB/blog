require 'yaml'
require 'date'

class Post
  class Renderer < Redcarpet::Render::HTML

    def initialize(slug, *args)
      @slug = slug
      super *args
    end

    def image(link, title, alt_text)
      unless link.match /^http|^\//
        link = "/images/#{@slug}/#{link}"
      end
      "</p><p class='image'><img src='#{link}' title='#{title}' alt='#{alt_text}' /><br /><span class='caption'>#{alt_text}</span>"
    end

  end
end

class Post
  attr_reader :content
  attr_reader :title
  attr_reader :date
  attr_reader :slug
  attr_reader :formatted_date

  def initialize(name)
    begin
      content = File.read("posts/#{name}.md")
    rescue
      return
    end

    match = content.match(/^---$(.*?)^---$(.*)/m)

    unless match.nil?
      meta_data = match[1]
      content = match[2]

      meta_data = YAML.load(meta_data)

      @title = meta_data["title"]
      @author = meta_data["author"]
      @tags = meta_data["tags"] || []
    end

    @date = name.match(/^\d{4}-\d{2}-\d{2}/)
    @slug = name[/#{@date}-(.*)$/,1]

    @formatted_date = Date.parse(@date.to_s).strftime("%d %B %Y")

    renderer = Post::Renderer.new(@slug)
    r = Redcarpet::Markdown.new(renderer, :fenced_code_blocks => true)
    @content = r.render(content)
  end
end
