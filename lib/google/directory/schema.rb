require "google/directory/schema/field"
require "google/directory/schema/field_type"

module Google
  module Directory
    class Schema < BaseApi
      def insert(key, fields)
        body = schema_api.insert.request_schema.new
        body.fields = fields.map(&:to_google_field)
        body.schema_name = key

        client.execute!(api_method: schema_api.insert,
                        body_object: body,
                        parameters: default_query)
      end

      def update(key, fields)
        body = schema_api.update.request_schema.new
        body.fields = fields.map(&:to_google_field)
        body.schema_name = key

        client.execute!(api_method: schema_api.update,
                        body_object: body,
                        parameters: default_query.merge(schemaKey: key))
      end

      private

      def schema_api
        @schema ||= directory_api.discovered_resources.find { |resource| resource.name == "schemas" }
      end
    end
  end
end
