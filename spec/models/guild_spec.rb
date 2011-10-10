require 'spec_helper'

describe Guild do
  it "should require a region, realm, and name" do
    guild = Guild.new(region: "", realm: "", name: "")
    guild.should_not be_valid
  end
  
  it "should require a supported region" do
    guild = Guild.new(region: "uk", realm: "Kil'jaeden", name: "Cheaty Cheetahs")
    guild.should_not be_valid
  end
end
