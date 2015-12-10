require "google/api_client"
require "google/client_builder/construction_helper"

module Google
  class ClientBuilder
    extend ConstructionHelper

    attr_accessor :user_email, :scopes, :authorize

    def self.key
      OpenSSL::PKey::RSA.new(ENV.fetch("GOOGLE_API_PRIVATE_KEY").gsub("\\n", "\n"),
                             "notasecret") # static default for Google P12 auth
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
      Google::APIClient::JWTAsserter.new(ENV.fetch("GOOGLE_API_SERVICE_ACCOUNT"), scopes, self.class.key)
    end

    def authorize?
      @authorize === true
    end
  end
end
