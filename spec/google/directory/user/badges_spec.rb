require "spec_helper"

module Google::Directory
  describe User::Badges do
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

    it "returns the name of available badges from google schema api" do
      schema_api = double(Google::Directory::Schema)
      badgeFields = [
        double(field_name: "foo"),
        double(field_name: "bar"),
      ]

      schema_double = double({fields: badgeFields})
      expect(schema_api).to receive(:get).with("badges").and_return(schema_double)

      badges_api = described_class.new(client_spy, schema_api)

      expect(badges_api.available).to eql(%w(foo bar))
    end
  end
end
