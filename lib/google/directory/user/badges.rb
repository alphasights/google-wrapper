module Google
  module Directory
    module User
      class Badges < BaseApi
        # Update a users badges
        #
        # @param user_key [String] Can be the user's primary email address, alias email address, or unique user ID.
        # @param badges [Array] An array of the badges (as Symbols or Strings)
        def update(user_key, badges)
          body = directory_api.users.patch.request_schema.new
          body.custom_schemas = { badges: badges.map { |badge| [badge, true] }.to_h }

          client.execute!(api_method: directory_api.users.patch,
            body_object: body,
            parameters: default_query.merge(userKey: user_key))
        end
      end
    end
  end
end
