module Google
  module Directory
    class Schema < BaseApi
      Field = Struct.new(:name, :type) do
        def to_google_field
          { fieldName: name, fieldType: type.to_s }
        end
      end
    end
  end
end
