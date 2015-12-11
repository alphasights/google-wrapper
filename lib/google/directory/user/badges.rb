module Google
  module Directory
    class User < BaseApi
      class Badges < BaseApi
        # Update a users badges
        #
        # @param user_key [String] Can be the user's primary email address, alias email address, or unique user ID.
        # @param badges [Hash] Hash of badges with boolean values
        def update(user_key, badges)
          body = directory_api.users.patch.request_schema.new
          body.custom_schemas = { badges: badges }

          client.execute!(api_method: directory_api.users.patch,
            body_object: body,
            parameters: default_query.merge(userKey: user_key))
        end
      end
    end
  end
end
