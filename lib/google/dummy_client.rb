require "ostruct"

module Google
  class DummyClient
    class UndefinedAPIError < RuntimeError; end

    APIS = {
      "directory_v1" => {
        "admin" => {
          "schemas" => %W(insert patch update delete get),
          "users" => %W(insert patch delete get),
        },
      },
      "v3" => {
        "calendar" => {
          "events" => %W(insert update delete get),
        },
      },
    }.freeze

    def initialize
      @class_cache = {}
      APIS.each do |version, stubs|
        stubs.each do |api, resources|
          cache_key = "#{api}::#{version}"

          @class_cache[cache_key] = DummyAPIFactory.new(api, version, APIS.fetch(version).fetch(api))
        end
      end
    end

    def discovered_api(api, version)
      cache_key = "#{api}::#{version}"
      @class_cache.fetch(cache_key)
    rescue KeyError
      raise UndefinedAPIError, <<-MSG
        The #{api} API for version #{version} is not stubbed out.
        See Google::DummyClient::APIS to see available API stubs.
      MSG
    end

    def execute(params)
      OpenStruct.new(data: OpenStruct.new(params))
    end

    alias_method :execute!, :execute
  end

  class DummyAPIFactory
    # Creates a new class for the API. This anonymous class should be garbage collected
    # in ruby > 2.1 so there's no need to worry about garbage collection.
    def self.new(name, version, method_chains)
      Class.new {
        method_chains.each do |method, child_methods|
          define_method method do
            methods = Hash[child_methods.map do |m|
              [m, OpenStruct.new(request_schema: OpenStruct, name: "#{name}.#{method}.#{m}")]
            end]

            OpenStruct.new(methods.merge(name: method))
          end
        end

        define_method "discovered_resources" do
          method_chains.map { |method, _| public_send(method) }
        end
      }.new
    end
  end
end
