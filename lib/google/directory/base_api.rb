module Google
  module Directory
    class BaseApi
      def initialize(client = nil)
        @client = client
      end

      private

      def default_query
        { customer: "my_customer", customerId: ENV.fetch("GOOGLE_ADMIN_CUSTOMER_ID") }
      end

      def directory_api
        @directory_api ||= client.discovered_api("admin", "directory_v1")
      end

      def client
        @client ||= Google::ClientBuilder.directory_client
      end
    end
  end
end
