module Google
  module Directory
    class Schema < BaseApi
      module FieldType
        class Boolean; def self.to_s; "BOOL"; end; end
        class String; def self.to_s; "STRING"; end; end
        class Integer; def self.to_s; "INT64"; end; end
      end
    end
  end
end
