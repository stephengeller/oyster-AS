require 'station'

describe Station do
  it "shows the zone" do
    aldgate_east = Station.new("Aldgate East", "zone 1")
    expect(aldgate_east.zone).to eq("zone 1")
  end

  it "shows the name of the station" do
    aldgate_east = Station.new("Aldgate East", "zone 1")
    expect(aldgate_east.name).to eq "Aldgate East"
  end 
end
