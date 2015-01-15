require 'validic/utils'
module Validic
  class Nutrition
    include Validic::Utils
    def initialize(attrs = {})
      attributes_builder(attrs, self)
    end
  end
end
