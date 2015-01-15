require 'validic/utils'
module Validic
  class Biometrics
    include Validic::Utils
    def initialize(attrs = {})
      attributes_builder(attrs, self)
    end
  end
end
