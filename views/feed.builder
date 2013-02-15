xml.instruct!
xml.feed :xmlns => 'http://www.w3.org/2005/Atom' do
  xml.title TITLE
  xml.link :href => "#{url_base}/feed", :rel => :self, :type => 'application/atom+xml'
  xml.link :href => "#{url_base}/archive", :rel => :alternate, :type => 'text/html'
  xml.id "#{url_base}/"
  xml.updated @posts.first.date.to_time.xmlschema

  @posts.each do |post|
    xml.entry do
      url = "#{url_base}/posts/#{post.name}"
      xml.title post.title, :type => :html
      xml.link :href => url, :rel => :alternate, :type => 'text/html'
      xml.published post.date.to_time.xmlschema
      xml.updated post.date.to_time.xmlschema

      xml.author do
        xml.name TITLE
      end

      xml.id url
      xml.content :type => :html, 'xml:base' => url do
        xml.cdata! post.content
      end
    end
  end
end
