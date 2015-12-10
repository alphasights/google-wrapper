require "spec_helper"

describe Google::DummyClient do
  subject(:client) { described_class.new }

  it "can generate a calendar dummy api interface" do
    calendar = client.discovered_api("calendar", "v3")
    expect(calendar.events.insert.name).to eql("calendar.events.insert")
    expect(calendar.events.update.name).to eql("calendar.events.update")
    expect(calendar.events.delete.name).to eql("calendar.events.delete")
    expect(calendar.events.get.name).to eql("calendar.events.get")
  end

  it "mimics google `discovered_resources` method" do
    calendar = client.discovered_api("calendar", "v3")

    events = calendar.discovered_resources.first
    expect(events.name).to eql("events")
    expect(events.insert.name).to eql("calendar.events.insert")
  end

  it "raises an error if it does not have that API defined" do
    expect{ client.discovered_api("v3", "foo") }
      .to raise_error(Google::DummyClient::UndefinedAPIError)
  end
end
