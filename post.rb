require 'yaml'

class Node
  attr_accessor :child
  attr_accessor :sibling
  attr_accessor :parent
  attr_accessor :text

  def initialize text, parent=nil, sibling=nil, child=nil
    @parent = parent
    @text = text
    @sibling = sibling
    @child = child
  end

  def level
    level = 1
    current = @parent
    until current.nil? do
      current = current.parent
      level = level + 1
    end
    level
  end

  def slug
    @text.gsub(/\W/, "_").downcase
  end
end

class Post
  class Renderer < Redcarpet::Render::HTML
    attr_accessor :outline

    def initialize(slug, *args)
      @outline = Node.new :root
      @last = @outline
      @slug = slug
      super *args
    end

    def image(link, title, alt_text)
      unless link.match /^http|^\//
        link = "/images/#{@slug}/#{link}"
      end
      "<p class='center'><img src='#{link}' title='#{title}' alt='#{alt_text}' /></p>"
    end

    def header(text, header_level)
      new_node = Node.new text
      if header_level == @last.level
        new_node.parent = @last.parent
        @last.sibling = new_node
      elsif header_level > @last.level
        new_node.parent = @last
        @last.child = new_node
      elsif header_level < @last.level
        new_node.parent = @last.parent.parent
        @last.parent.sibling = new_node
      end
      @last = new_node

      "<h#{header_level} id='#{new_node.slug}'>#{text}</h#{header_level}>"
    end
  end
end

class Post
  attr_reader :content
  attr_reader :title
  attr_reader :author
  attr_reader :date
  attr_reader :tags
  attr_reader :outline
  attr_reader :slug

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

    renderer = Post::Renderer.new(@slug)
    r = Redcarpet::Markdown.new(renderer, :fenced_code_blocks => true)
    @content = r.render(content)
    @outline = renderer.outline.child
  end
end
