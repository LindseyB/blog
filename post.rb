require "yaml"
require "date"

class Post
  class Renderer < Redcarpet::Render::HTML
    def initialize(slug, *args)
      @slug = slug
      super(*args)
    end

    def image(link, title, alt_text)
      unless link.match?(/^http|^\//)
        link = "/images/#{@slug}/#{link}"
      end
      "</p><p class='image'><img src='#{link}' title='#{title}' alt='#{alt_text}' /><br /><span class='caption'>#{alt_text}</span>"
    end

    def table(header, body)
      "<table class='pure-table pure-table-striped'><thead>#{header}</thead><tbody>#{body}</tbody></table>"
    end
  end
end

class Post
  attr_reader :name
  attr_reader :title
  attr_reader :date
  attr_reader :slug

  def initialize(name)
    @name = name
    begin
      content = File.read("posts/#{name}.md")
    rescue
      return
    end

    match = content.match(/^---$(.*?)^---$(.*)/m)

    unless match.nil?
      meta_data = match[1]
      @content_raw = match[2]

      meta_data = YAML.load(meta_data)

      @title = meta_data["title"]
      @date = meta_data["date"]
    end

    # for older posts
    date_str = name.match(/^\d{4}-\d{2}-\d{2}/).to_s
    @date ||= Date.parse(date_str)
    @slug = name[/#{date_str}-?(.*)$/, 1]
  end

  def content
    @content ||= begin
      renderer = Post::Renderer.new(@slug)
      r = Redcarpet::Markdown.new(renderer, fenced_code_blocks: true, tables: true)
      r.render(@content_raw)
    end
  end

  def formatted_date
    @formatted_date ||= @date.strftime("%d %B %Y")
  end

  def blurb(length = 20)
    if content.length > length
      blurb = Sanitize.fragment(content)[0...(length - 3)] + "..."
    end
  end

  def image
    doc = Nokogiri::HTML(content)
    if img = doc.xpath("//img").first
      src = img.attr("src")
      return nil if src == "/images/youtube_placeholder.png"
      URI(src).host ? src : "http://rarlindseysmash.com#{src}"
    end
  end
end
