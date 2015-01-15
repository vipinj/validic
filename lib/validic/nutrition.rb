require 'validic/extra'
module Validic
  class Nutrition
    def initialize(attrs = {})
      attrs.each do |k, v|
        if k == "extras"
          v = Validic::Extra.new(JSON.parse(v))
          instance_variable_set("@#{k}", v)
          self.class.send(:attr_reader, k)
        else
          instance_variable_set("@#{k}", v)
          self.class.send(:attr_reader, k)
        end
      end
    end
  end
end
