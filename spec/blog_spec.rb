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
    stub_request(:get, "https://itch.io/api/1//my-games")
      .to_return(status: 200, body: games_response.to_json, headers: {"Content-Type" => "application/json; charset=UTF-8"})
  end

  it "should redirect from home page" do
    get "/"
    expect(last_response).to be_redirect
    follow_redirect!
    expect(last_response).to be_ok
    expect(last_response.body).to include("Projects")
    expect(last_response.body).to include("A Game")
  end
end
