class Post
  attr_reader :content
  attr_reader :title
  attr_reader :author
  attr_reader :date

  def initialize(name)
    begin
      content = File.read("posts/#{name}.md")
    rescue
    end

    line_end = content.index("\n")
    title, content = content[0..line_end], content[line_end+1..-1]

    line_end = content.index("\n")
    author, content = content[0..line_end], content[line_end+1..-1]

    r = Redcarpet::Markdown.new(Redcarpet::Render::HTML, :fenced_code_blocks => true)
    @content = r.render(content)
    @title = title[title.index(":")+1..-1].strip
    @author = author[author.index(":")+1..-1].strip
    @date = name.match(/^\d{4}-\d{2}-\d{2}/)
  end
end
