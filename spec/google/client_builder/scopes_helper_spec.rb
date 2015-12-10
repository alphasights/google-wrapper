require "spec_helper"

describe Google::ClientBuilder::ScopesHelper do
  it "can give you sane default scopes for different uses" do
    expect(described_class.calendar).to eql(["https://www.googleapis.com/auth/calendar"])
    expect(described_class.directory).to eql(["https://www.googleapis.com/auth/admin.directory.user",
                                              "https://www.googleapis.com/auth/admin.directory.userschema"])
  end
end
