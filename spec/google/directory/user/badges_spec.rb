require "spec_helper"

module Google::Directory::User
  describe Badges do
    subject(:badges_api) { described_class.new(client_spy) }
    let(:client_spy) { Google::DummyClient.new }

    before do
      allow(ENV).to receive(:fetch).with("GOOGLE_ADMIN_CUSTOMER_ID").and_return("1234")
    end

    it "proxies patch to a google api client" do
      result = badges_api.update("john.bohn@alphasights.com", {
        client_portal: true,
        reporting_world: true,
      })

      api_method = result.data.api_method
      body_object = result.data.body_object
      parameters = result.data.parameters

      expect(api_method.name).to eql("admin.users.patch")
      expect(body_object.custom_schemas).to eql({
        badges: {
          client_portal: true,
          reporting_world: true,
        }
      })

      expect(parameters).to eql({
        customer: "my_customer",
        customerId: "1234",
        userKey: "john.bohn@alphasights.com"
      })
    end
  end
end
