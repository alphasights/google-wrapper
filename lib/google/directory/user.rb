require "google/directory/user/badges"

module Google
  module Directory
    class User < BaseApi
      def get(user_key)
        parameters = { userKey: user_key, projection: "full" }

        client.execute!(api_method: directory_api.users.get,
                        parameters: default_query.merge(parameters)).data
      end
    end
  end
end
