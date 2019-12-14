require File.expand_path '../spec_helper.rb', __FILE__

describe "Blog" do
  it "should redirect from home page" do
    get '/'
    expect(last_response).to be_redirect
    follow_redirect!
    expect(last_response).to be_ok
    expect(last_response.body).to include('Projects')
  end
end