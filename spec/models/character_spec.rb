require 'spec_helper'

describe Character do
  it "should require a region, realm, and name" do
    character = Character.new(region: "", realm: "", name: "")
    character.should_not be_valid
  end
  
  it "should require a supported region" do
    character = Character.new(region: "uk", realm: "Kil'jaeden", name: "Thehermit")
    character.should_not be_valid
  end
  
  it "should accept a valid region" do
    character = Character.new(region: "us", realm: "Kil'jaeden", name: "Thehermit")
    character.should be_valid
  end
end
