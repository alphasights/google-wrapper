require "spec_helper"

module Google::Directory
  describe Schema do
    subject(:schema_api) { described_class.new(client_spy) }
    let(:client_spy) { Google::DummyClient.new }
    let(:badge_fields) do
      [Schema::Field.new("corporate_portal", Schema::FieldType::Boolean),
        Schema::Field.new("compliance", Schema::FieldType::Boolean)]
    end

    before do
      allow(ENV).to receive(:fetch).with("GOOGLE_ADMIN_CUSTOMER_ID").and_return("1234")
    end

    it "proxies update to a google api client" do
      result = schema_api.update("badges", badge_fields)
      api_method = result.data.api_method
      body_object = result.data.body_object
      parameters = result.data.parameters

      expect(api_method.name).to eql("admin.schemas.update")
      expect(body_object.schema_name).to eql("badges")
      expect(body_object.fields).to match_array([
        { fieldName: "corporate_portal", fieldType: "BOOL" },
        { fieldName: "compliance", fieldType: "BOOL" }
      ])
      expect(parameters).to eql({ customer: "my_customer", customerId: "1234", schemaKey: "badges" })
    end

    it "proxies insert to a google api client" do
      result = schema_api.insert("badges", badge_fields)
      api_method = result.data.api_method
      body_object = result.data.body_object
      parameters = result.data.parameters

      expect(api_method.name).to eql("admin.schemas.insert")
      expect(body_object.schema_name).to eql("badges")
      expect(body_object.fields).to match_array([
        { fieldName: "corporate_portal", fieldType: "BOOL" },
        { fieldName: "compliance", fieldType: "BOOL" }
      ])
      expect(parameters).to eql({ customer: "my_customer", customerId: "1234" })
    end

    it "proxies get to a google api client" do
      result = schema_api.get("badges")
      api_method = result.api_method
      parameters = result.parameters

      expect(api_method.name).to eql("admin.schemas.get")
      expect(parameters).to eql({ customer: "my_customer", customerId: "1234", schemaKey: "badges" })
    end
  end

  describe Schema::Field do
    it "takes a field key name and a type (as a class)" do
      field = described_class.new("test", Schema::FieldType::String)
      expect(field.name).to eql("test")
      expect(field.type).to eql(Schema::FieldType::String)
    end

    it "can be converted to google compatible argument" do
      field = described_class.new("test", Schema::FieldType::String)

      expect(field.to_google_field).to eql({
        fieldName: "test",
        fieldType: "STRING",
      })
    end

    it "included type maps" do
      field = described_class.new("test", Schema::FieldType::String)
      expect(field.to_google_field[:fieldType]).to eql("STRING")

      field = described_class.new("test", Schema::FieldType::Boolean)
      expect(field.to_google_field[:fieldType]).to eql("BOOL")

      field = described_class.new("test", Schema::FieldType::Integer)
      expect(field.to_google_field[:fieldType]).to eql("INT64")
    end
  end
end
