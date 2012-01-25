require 'yaml'
class Post
  attr_reader :content
  attr_reader :title
  attr_reader :author
  attr_reader :date
  attr_reader :tags

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

    r = Redcarpet::Markdown.new(Redcarpet::Render::HTML, :fenced_code_blocks => true)
    @content = r.render(content)

    @date = name.match(/^\d{4}-\d{2}-\d{2}/)
  end
end
