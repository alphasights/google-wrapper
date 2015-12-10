module Google
  class ClientBuilder
    class ScopesHelper
      def self.calendar
        ["https://www.googleapis.com/auth/calendar"]
      end

      def self.directory
        ["https://www.googleapis.com/auth/admin.directory.user",
         "https://www.googleapis.com/auth/admin.directory.userschema"]
      end
    end
  end
end
