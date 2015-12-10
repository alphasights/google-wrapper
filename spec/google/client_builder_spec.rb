require "spec_helper"

describe Google::ClientBuilder do
  it "can take a user email (for when you're acting on behalf of a user)" do
    scopes = Google::ClientBuilder::ScopesHelper.directory

    asserter = double("Google::APIClient::JWTAsserter")
    authorization = double(generate_authenticated_request: double)
    key = Google::ClientBuilder.key

    allow_any_instance_of(Google::ClientBuilder).to receive(:asserter).and_return(asserter)
    expect(asserter).to receive(:authorize).with("jjbohn@gmail.com").and_return(authorization)

    client = described_class.new do |c|
      c.user_email = "jjbohn@gmail.com"
      c.scopes = Google::ClientBuilder::ScopesHelper.directory
      c.authorize!
    end.build

    expect(client).to be_instance_of(Google::APIClient)
    expect(client.authorization).to equal(authorization)
  end
end
