module Validic
  class Sleep
    # attr_reader examples:
    # Sleep.new.timestamp
    # This needs better docs
    def initialize(attrs={})
      #create attr_reader for all key value pairs
      attrs.each do |k, v|
        instance_variable_set("@#{k}", v)
        self.class.send(:attr_reader, k)
      end
    end
  end
end
