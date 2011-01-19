require "spec_helper"

describe "routes for Pages" do
  
  it "should not route to Pages" do
    { :get => "/pages"}.should_not be_routable
  end
  
  it "should route / to pages#index" do
    { :get => "/" }.should route_to(:controller => "pages", :action => "index")
  end
end