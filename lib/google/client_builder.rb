require "google/api_client"
require "google/client_builder/construction_helper"

module Google
  class ClientBuilder
    extend ConstructionHelper

    PRIVATE_KEY = ENV.fetch("GOOGLE_API_PRIVATE_KEY").gsub("\\n", "\n")
    PRIVATE_KEY_SECRET = "notasecret" # static default for Google P12 auth
    SERVICE_ACCOUNT_EMAIL = ENV.fetch("GOOGLE_API_SERVICE_ACCOUNT")

    attr_accessor :user_email, :scopes, :authorize

    def self.key
      OpenSSL::PKey::RSA.new(PRIVATE_KEY, PRIVATE_KEY_SECRET)
    end

    def initialize
      yield(self) if block_given?
    end

    def authorize!
      @authorize = true
    end

    def build
      Google::APIClient.new(application_name: "google-wrapper", application_version: Google::Wrapper::VERSION).tap do |client|
        client.authorization = asserter.authorize(user_email) if authorize?
      end
    end

    private

    def asserter
      Google::APIClient::JWTAsserter.new(SERVICE_ACCOUNT_EMAIL, scopes, self.class.key)
    end

    def authorize?
      @authorize === true
    end
  end
end
