module Validic
  class Nutrition
    def initialize(attrs = {})
      attrs.each do |k, v|
        instance_variable_set("@#{k}", v)
        self.class.send(:attr_reader, k)
      end
    end
  end
end
