require File.expand_path "../spec_helper.rb", __FILE__

describe "Blog" do
  let(:games_response) do
    {
      games: [
        {
          title: "A Game",
          url: "http://example.com",
          cover_url: "http://example.com/example.jpg"
        }
      ]
    }
  end

  before do
    stub_request(:get, "https://itch.io/api/1/#{ENV["ITCH_API_KEY"]}/my-games")
      .to_return(status: 200, body: games_response.to_json, headers: {"Content-Type" => "application/json; charset=UTF-8"})
  end

  describe "/" do
    it "should redirect from home page" do
      get "/"
      expect(last_response).to be_redirect
      follow_redirect!
      expect(last_response).to be_ok
      expect(last_response.body).to include("Projects")
      expect(last_response.body).to include("A Game")
    end
  end

  describe "/index.php" do
    it "should direct from /index.php" do
      get "/index.php"
      expect(last_response).to be_redirect
      follow_redirect!
      expect(last_response).to be_ok
      expect(last_response.body).to include("Projects")
      expect(last_response.body).to include("A Game")
    end
  end

  describe "/posts/:id" do
    it "renders the post content" do
      get "/posts/diy-led-hula-hoop"
      expect(last_response).to be_ok
      expect(last_response.body).to include("I needed to build a simple LED hula hoop.")
    end
  end

  describe "/archive" do
    it "should render a list of posts" do
      get "/archive"
      expect(last_response).to be_ok
      expect(last_response.body).to include("DIY Programmable LED Hula Hoop")
      expect(last_response.body).to include("Blender Rigify to Unity Ragdoll")
    end
  end

  describe "/projects" do
    it "should render a list of projects" do
      get "/projects"
      expect(last_response).to be_ok
      expect(last_response.body).to include("Projects")
      expect(last_response.body).to include("A Game")
    end
  end

  describe "/about" do
    it "should render the about page" do
      get "/about"
      expect(last_response).to be_ok
      expect(last_response.body).to include("About")
      expect(last_response.body).to include("I'm Lindsey")
    end
  end

  describe "/links" do
    it "should render links page" do
      get "/links"
      expect(last_response).to be_ok
      expect(last_response.body).to include("Twitch")
      expect(last_response.body).to include("Personal Website")
    end
  end

  describe "/rss.xml" do
    it "should render details about the last 10 posts" do
      get "/rss.xml"
      expect(last_response).to be_ok
      # I don't actually think anyone uses this so I'm not even going to valiadate it
    end
  end
end
