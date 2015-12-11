require "spec_helper"

module Google::Directory
  describe User do
    subject(:user_api) { described_class.new(client_spy) }
    let(:client_spy) { Google::DummyClient.new }

    before do
      allow(ENV).to receive(:fetch).with("GOOGLE_ADMIN_CUSTOMER_ID").and_return("1234")
    end

    it "proxies a get with full project to a google api client when no extra arguments are sent" do
      result = user_api.get("john.bohn@alphasights.com")

      api_method = result.api_method
      parameters = result.parameters

      expect(api_method.name).to eql("admin.users.get")
      expect(parameters).to eql({
        customer: "my_customer",
        customerId: "1234",
        userKey: "john.bohn@alphasights.com",
        projection: "full",
      })
    end
  end
end
