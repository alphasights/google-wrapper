require "google/client_builder/scopes_helper"

module Google
  class ClientBuilder
    module ConstructionHelper
      def calendar_client(user_email)
        Google::ClientBuilder.new do |c|
          c.user_email = user_email
          c.scopes = ScopesHelper.calendar
          c.authorize!
        end.build
      end

      def directory_client
        ClientBuilder.new do |c|
          c.user_email = ENV.fetch("GOOGLE_ADMIN_USER_EMAIL")
          c.scopes = ScopesHelper.directory
          c.authorize!
        end.build
      end
    end
  end
end
