class Post
  attr_reader :content
  attr_reader :title

  def initialize(name)
    begin
      content = File.read("posts/#{name}.md")
    rescue
    end

    line_end = content.index("\n")
    title, content = content[0..line_end], content[line_end+1..-1]

    r = Redcarpet::Markdown.new(Redcarpet::Render::HTML, :fenced_code_blocks => true)
    @content = r.render(content)
    @title = title[title.index(":")+1..-1].strip
  end
end
