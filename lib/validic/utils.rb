require 'validic/extra'
module Validic
  module Utils
    def attributes_builder(attrs, obj)
      attrs.each do |k, v|
        v = Validic::Extra.new(JSON.parse(v)) if k == "extras"
        instance_variable_set("@#{k}", v)
        obj.class.send(:attr_reader, k)
      end
    end
  end
end
